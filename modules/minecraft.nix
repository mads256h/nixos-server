# vim: ts=2 sw=2 et
{ config, lib, pkgs, ... }:

let
  cfg = config.services.minecraft-ftb-server;

  stopScript = pkgs.writeShellScript "minecraft-ftb-server-stop" ''
    echo stop > ${config.systemd.sockets.minecraft-ftb-server.socketConfig.ListenFIFO}
    # Wait for the PID of the minecraft server to disappear before
    # returning, so systemd doesn't attempt to SIGKILL it.
    while kill -0 "$1" 2> /dev/null; do
      sleep 1s
    done
  '';


  serverPort = cfg.serverPort;
in {
  options = {
    services.minecraft-ftb-server = {

      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          If enabled, start a Minecraft Server. The server
          data will be loaded from and saved to
          {option}`services.minecraft-ftb-server.dataDir`.
        '';
      };

      dataDir = lib.mkOption {
        type = lib.types.path;
        default = "/var/lib/minecraft";
        description = lib.mdDoc ''
          Directory to store Minecraft database and other state/data files.
        '';
      };

      serverPort = lib.mkOption {
        type = lib.types.port;
        default = 25565;
      };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to open ports in the firewall for the server.
        '';
      };

      serverExecutable = lib.mkOption {
        type = lib.types.path;
        default = "minecraft-server.jar";
        description = lib.mdDoc ''
          The minecraft server executable to run.
        '';
      };

      jvmOpts = lib.mkOption {
        type = lib.types.separatedString " ";
        default = "-Xmx2048M -Xms2048M";
        description = lib.mdDoc "JVM options for the Minecraft server.";
      };

      javaPackage = lib.mkOption {
        type = lib.types.package;
        default = pkgs.jdk;
        defaultText = lib.literalExpression "pkgs.jdk";
        example = lib.literalExpression "pkgs.jdk8_headlesse";
        description = lib.mdDoc "Version of java to run.";
      };

      lowCpuWhenEmpty = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc "Wether or not to limit cpu usage when nobody is online";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.minecraft = {
      description     = "Minecraft server service user";
      #home            = cfg.dataDir;
      createHome      = true;
      isSystemUser    = true;
      group           = "minecraft";
    };
    users.groups.minecraft = {};

    systemd.sockets.minecraft-ftb-server = {
      bindsTo = [ "minecraft-ftb-server.service" ];
      socketConfig = {
        ListenFIFO = "/run/minecraft-ftb-server.stdin";
        SocketMode = "0660";
        SocketUser = "minecraft";
        SocketGroup = "minecraft";
        RemoveOnStop = true;
        FlushPending = true;
      };
    };

    systemd.services.minecraft-ftb-server = {
      description   = "Minecraft Server Service";
      wantedBy      = [ "multi-user.target" ];
      requires      = [ "minecraft-ftb-server.socket" ];
      after         = [ "network.target" "minecraft-ftb-server.socket" ];

      serviceConfig = {
        ExecStart = "${cfg.javaPackage}/bin/java ${cfg.jvmOpts} -jar ${cfg.serverExecutable} nogui";
        ExecStop = "${stopScript} $MAINPID";
        Restart = "always";
        User = "minecraft";
        WorkingDirectory = cfg.dataDir;

        StandardInput = "socket";
        StandardOutput = "journal";
        StandardError = "journal";

        # Hardening
        CapabilityBoundingSet = [ "" ];
        DeviceAllow = [ "" ];
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateDevices = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectSystem = "strict";
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        ReadWritePaths = cfg.dataDir;
        RemoveIPC = true;
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [ "@system-service" "~@privileged" ];
        SystemCallErrorNumber = "EPERM";
        UMask = "0077";
      };
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedUDPPorts = [ serverPort ];
      allowedTCPPorts = [ serverPort ];
    };

    systemd.services.minecraft-ftb-server-limiter = lib.mkIf cfg.lowCpuWhenEmpty {
      description = "Limit minecraft server cpu usage when nobody is online";
      wantedBy    = [ "multi-user.target" ];
      requires    = [ "minecraft-ftb-server.service" ];
      after       = [ "minecraft-ftb-server.service" ];

      script = ''
        set +e
        login_regex_pattern="\[User Authenticator #.*/INFO\]: UUID of player"
        logout_regex_pattern="lost connection"
        service_name="minecraft-ftb-server"
        service_pid=$(${pkgs.systemd}/bin/systemctl show --property MainPID --value $service_name)

        login_count=0
        cpulimit_pid=0

        trap 'unlimit_cpu' EXIT HUP INT QUIT PIPE TERM

        limit_cpu() {
            echo "Limiting CPU time"
            ${pkgs.util-linux}/bin/taskset -acp 0 $service_pid > /dev/null
            ${pkgs.cpulimit}/bin/cpulimit --pid=$service_pid --limit=10 &
            cpulimit_pid=$!
        }

        unlimit_cpu() {
            echo "Unlimiting CPU time"
            ${pkgs.util-linux}/bin/taskset -acp 0-3 $service_pid > /dev/null
            ${pkgs.coreutils}/bin/kill $cpulimit_pid
        }

        perform_login_action() {
            ((login_count+=1))
            if [ $login_count -eq 1 ]; then
                unlimit_cpu
            fi
        }

        perform_logout_action() {
            ((login_count-=1))
            if [ $login_count -eq 0 ]; then
                limit_cpu
            fi
            if [ $login_count -le 0 ]; then
                login_count=0
            fi
        }


        limit_cpu
        # Monitor the journalctl logs in real-time
        ${pkgs.systemd}/bin/journalctl --follow -n 0 -u "$service_name" |
        while IFS= read -r log_entry; do
            if [[ "$log_entry" =~ $login_regex_pattern ]]; then
                perform_login_action "$log_entry"
            fi
            if [[ "$log_entry" =~ $logout_regex_pattern ]]; then
                perform_logout_action "$log_entry"
            fi
        done
      '';

      serviceConfig.ExecStop = "${pkgs.coreutils}/bin/kill $MAINPID";
    };
  };
}
