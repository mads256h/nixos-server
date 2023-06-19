# vim: ts=2 sw=2 et
{ config, lib, pkgs, ... }:

let
  cfg = config.services.pihole;

  dnsPort = cfg.dnsPort;
  httpPort = cfg.httpPort;

in {
  options = {
    services.pihole = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      image = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "pihole/pihole";
      };

      version = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "2023.05.02";
      };

      dnsPort = lib.mkOption {
        type = lib.types.port;
        default = 5353;
      };

      httpPort = lib.mkOption {
        type = lib.types.port;
        default = 8080;
      };

      inDns = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "8.8.8.8";
      };

      routerDomain = lib.mkOption {
        type = lib.types.singleLineStr;
      };

      routerIp = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "192.168.1.1";
      };

      routerCidr = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "192.168.1.0/16";
      };

      webPassword = lib.mkOption {
        type = lib.types.singleLineStr;
        default = "toor";
      };

      customDnses = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [];
      };

      adlists = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [];
      };

      regexes = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [];
      };

      blacklist = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [];
      };

      whitelist = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.backend = lib.mkForce "docker";

    virtualisation.oci-containers.containers.pihole = {
      image = "${cfg.image}:${toString cfg.version}";
      ports = [
        "${toString cfg.dnsPort}:53/udp"
        "${toString cfg.dnsPort}:53/tcp"
        "${toString cfg.httpPort}:80/tcp"
      ];
      environment = {
        TZ = config.time.timeZone;
        WEB_PORT = "80";
        WEBPASSWORD = cfg.webPassword;
        PIHOLE_DNS_ = cfg.inDns;
        REV_SERVER = "true";
        REV_SERVER_DOMAIN = cfg.routerDomain;
        REV_SERVER_TARGET = cfg.routerIp;
        REV_SERVER_CIDR = cfg.routerCidr;
        DNSMASQ_LISTENING = "all";
      };
      extraOptions = [
        "--add-host=host.docker.internal:host-gateway"
      ];
    };

    systemd.services."docker-pihole".postStart = ''
      while ! docker ps | grep pihole; do
        sleep 10s
        echo "Waiting on container"
      done
      sleep 30s

      # add custom dnses
      ${builtins.foldl' (x: y: x + "docker exec pihole pihole -a addcustomdns \"" + y.ip + "\" \"" + y.name + "\" false\n") ""  cfg.customDnses}

      # Add adlists
      ${builtins.foldl' (x: y: x + "docker exec pihole pihole -a adlist add \"" + y + "\"\n") "" cfg.adlists}

      # Add regexes
      ${builtins.foldl' (x: y: x + "docker exec pihole pihole --regex '" + y + "'\n") "" cfg.regexes}

      # Add blacklisted domains
      ${builtins.foldl' (x: y: x + "docker exec pihole pihole -b \"" + y + "\"\n") "" cfg.blacklist}

      # Add whitelisted domains
      ${builtins.foldl' (x: y: x + "docker exec pihole pihole -w \"" + y + "\"\n") "" cfg.whitelist}

      # Apply changes
      docker exec pihole pihole -g
    '';
  };
}
