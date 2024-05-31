# vim: ts=2 sw=2 et
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, ... }:

let
  authorizedKeys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeCSo+ztID41jlKZIy++UdhacKy0I4A/qqCWBBU1RP1NnoKdMcFqXyKJFLsltpuTuWKf9WnTgT+KCidMR8Foysdic5i7lGy4TMP8sa+RqNVUhLM93fM7YHrmGZHVbrg0rNVKnbFv/0lDZLiyp/l7B7vmuBtE3pCYW7nbFvoje+5pWDrpFL16qAFgIM5i3Ly9adkkObVw1Nz4tkjS5i6AJQc5ZYFzipVl5XU9NHdxg2SQrXokeX59AEN0UaUuUm/Ft0Mxyu01MyuHcqLK/b2netJrF/THj4bYu629IqDe+FT+APihhlvp40WI8Py9/dl6OSzB35XaQ1X60WBfqgLFgu6vM3NgItzVjRjb72paJ6YdVkhMJZezMdJxKfxrLXJPTLQELhETB0mFtM4tMb2Mh43Jp3oWPLg9ZtFEcKlafAWuHpbRHRsjD58UawrB3M/uq8+T+jmlh9CSRdcjIlf+Oz1AANk2rU/voUE8jhzeRLOwLNEahAb1d5mBLklOK9351gzRmYJxPuggdR0EiRchE59JiSUAmGxky0bHyOfOoqdLkd5cIxmv8FTqY2BXvHJhe8DpWaxYt/rR9ckTiNyJ+XgkvpGMDbwpoJBh1ELmZ2Iy3mg/r2Gmw83eK4w+q+Wzz3Nhm8flVikL+DAwPnfV8dObzyC62LNTWos1Gb+lY7Aw== mads@DESKTOP-MADS"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+dpaPAPx8PiwvhUSKmVf1IGWpFcGGNP3suSaxgy+Cxd0EuqpSZekFbO9RliGHt/yE9/u1MeNjntvwfO95bEIYkq9n12jiGKTdG+Qt6SI7IesE/UrPK/yHe2QogjAaUU6I5rAigCIM9Q7FYosU0nsWWQMjdkbyQ0OtquT3Me5NXOWhFWXRZr/molgO3EQKI4ElSUDlWgp9fJLALGE+3Jp88coPnp+yfxI2UqMY6VyranYBaiIbKv27YlaqMkhh21DNYh+smQCoz4DuSNEZiqrmLFGZoqBEO5qptu+HfIRsLwtBAKYu5s2ucZmjlF54BoRwfzDvAMuvZs6o2AB+TDBw+OANUBH4SLiD/9oBOyvCeNzFQuUViElCBI+QGbdgtXUWc6gwmMYX0lxfbIgcnmkeQL0GL4floawXWg48hvKMhuEvW8WimTHiZBi8f1ZxYaTs57BLmdEynvOSwi2ODhGMjT1au11bo5O2s9AtfQfgl57br7FSgsCzBMstcNsS3S/NcngYA5VXVwPBR1KyJVFicxcGbHRf0fbfdI1GQWgAV2fbxGmDDrqW7IH6w4SAR+6bYqNOEv51ijVvNXU9cBJQ5qlH7hj7TJpEWn5UR7LdTm96lCsaa5AICOlfkXppiOq8qRACkd1TqcT9Dq30fzuFND3Xghg8cuZ9P6zv700uyQ== mads@laptop-mads"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5bU6DBgeyhx5r6Dvx+EL65jatr8zdDaUiDlCMIFvSdvPET6ek236E/ASMagjd4J2d1VHJ8YNEgxaaTDiXKBS4LhtZh3kW3pOIVaL/Uggv9ONX+PKcMA0vJV1P3+JFEc9GZoArN17XXmFdTcPrvUVWJ1wlcWogu7nmIOxsvU87eL5mBhu38aOlJqYjWoXUVtUZw00JY//CBrLNLPl87BG3P4vYWuA0FF8gWfp8r0DPDNQHoXRRhuWRaplfaEB4fDP+FfZtNJw+9oETToXo0MoC8nEiH8KxWWKyBosYU2+UXa5M8Vh44GoqlGFRKW8XaxR0BQmiKUMPVziBa8Xr0GXxagW3eKsmSy4c9qNb38iCrrJgHZ2oL1n56kf4AUTnWQsioQHhFj+tnKM4msmzsfd/XQr/WFiKbgoG+4rv5erEH/5bpoXJjpW5u7drpcjBkwEuFn/u3W3aCdNlYpjp6LJxOuZb5bM9DMM8KFoCNVUg/rvc2n2RQi8HkH7vvAs9WuNg6+riWPy8irEZUa0MT80xonaVA+zB51AWNeqotBb0k1kFfyvmg9lgQiVkqMc/rnKMy4s6H8iXNap8zpSfWqowDEQnzTipf+SWV46u/1JkyL653ohraFSaf13QP52aZtalfGFCrM/g0oYMVhNQ6SkiRBogOxWj2klEpsO6x7xe1Q== u0_a107@localhost"
        ];
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixpkgs/nixos/modules/profiles/minimal.nix>
      <nixpkgs/nixos/modules/profiles/hardened.nix>
      ./minecraft.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  security.lockKernelModules = false;
  security.protectKernelImage = false;

  environment.noXlibs = false;

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
  networking.hostName = "server-mads";

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dk";
  };

  nixpkgs.config.allowUnfree = true;


  users = {
    mutableUsers = false;
    users."root" = {
      password = "toor";
      openssh.authorizedKeys.keys = authorizedKeys;
    };

    users."mads" = {
      isNormalUser = true;
      uid = 1000;
      password = "toor";
      openssh.authorizedKeys.keys = authorizedKeys;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bind
    git
    wireguard-tools
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
        show_cpu_frequency = true;
        show_cpu_temperature = true;
      };
    };
  };

  # Wireguard

  networking.nat.enable = true;
  networking.nat.externalInterface = "enp1s0";
  networking.nat.internalInterfaces = [ "wg0" ];

  networking.wireguard.interfaces."wg0" = {
    # Determines the IP address and subnet of the server's end of the tunnel interface.
    ips = [ "10.100.0.1/24" ];

    # The port that WireGuard listens to. Must be accessible by the client.
    listenPort = 51820;

    # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
    postSetup = ''
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ${config.networking.nat.externalInterface} -j MASQUERADE
    '';

    # This undoes the above command
    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ${config.networking.nat.externalInterface} -j MASQUERADE
    '';

    # Path to the private key file.
    #
    # Note: The private key can also be included inline via the privateKey option,
    # but this makes the private key world-readable; thus, using privateKeyFile is
    # recommended.
    privateKeyFile = "/mnt/data/wireguard/private-key";

    peers = [
      { # Android
        publicKey = "mFSLE2wdyrjQvsk3Y9uw2gu4EfV4yoenuQhMPSgHiWM=";
        #presharedKeyFile = "/mnt/data/wireguard/android-preshared-key";
        allowedIPs = [ "10.100.0.2/32" ];
      }
    ];
  };


  # List services that you want to enable:

  # Trim ssds weekly
  services.fstrim.enable = true;

  # Enable fail2ban
  services.fail2ban = {
    #enable = true;
    ignoreIP = [
      "127.0.0.0/8"
      "172.16.0.0/12"
      "10.0.1.0/24"
    ];
    #jails = {
    #  "nginx-spam" = ''
    #    enabled  = true
    #    filter   = nginx-spam
    #    logpath  = /var/log/nginx/access.log
    #    backend  = auto
    #    maxretry = 3
    #    findtime = 600
    #  '';
    #};
  };

  # fail2ban custom filters
  environment.etc."fail2ban/filter.d/nginx-spam.conf".text = ''
    [Definition]
    failregex = <HOST>.*" (31|40|51|53|301).*$
  '';

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ "127.0.0.1:5232" ];
        ssl = false;
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/mnt/data/radicale/users";
        htpasswd_encryption = "md5";
      };
      storage.filesystem_folder = "/mnt/data/radicale/collections";
      web.type = "none";
    };
  };

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "mail@madsmogensen.dk";

  services.nginx = {
    enable = true;

    # recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."home.madsmogensen.dk" =  {
      enableACME = true;
      forceSSL = true;

      locations."/radicale/" = {
        proxyPass = "http://localhost:5232/";
        extraConfig =
          "proxy_set_header  X-Script-Name /radicale;" +
          "proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;" +
          "proxy_set_header  Host $host;" +
          "proxy_pass_header Authorization;"
          ;
      };
    };

    virtualHosts."file.madsmogensen.dk" = {
      enableACME = true;
      forceSSL = true;
      root = "/mnt/data/file.madsmogensen.dk/www";
    };

    virtualHosts."server-mads.lan" =  {
      # Only allow local connections to this virtual host
      extraConfig =
          "allow 10.0.1.0/24;" +
          "deny all;"
          ;

      locations."/radicale/" = {
        proxyPass = "http://localhost:5232/";
        extraConfig =
          "proxy_set_header  X-Script-Name /radicale;" +
          "proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;" +
          "proxy_set_header  Host $host;" +
          "proxy_pass_header Authorization;"
          ;
      };
    };
  };

  services.minecraft-ftb-server = {
    enable = false;
    dataDir = "/mnt/data/minecraft/FeedTheBeast";
    openFirewall = true;
    serverExecutable = "/mnt/data/minecraft/FeedTheBeast/FTBServer-1.7.10-1614.jar";
    jvmOpts = "-server -Xms512M -Xmx2048M -XX:PermSize=256M -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm";
    lowCpuWhenEmpty = true;
    javaPackage = pkgs.jdk8;
  };

  services.minecraft-server = {
    enable = false;
    eula = true;
    dataDir = "/mnt/data/minecraft-aau";
    openFirewall = true;
  };

  # Exchange to imap / smtp gateway
  services.davmail = {
    enable = true;
    url = "https://mail.aau.dk/EWS/Exchange.asmx";
    config = {
      davmail.mode = "EWS";
      davmail.allowRemote = true;
      davmail.ssl.keystoreType = "PKCS12";
      davmail.ssl.keyPass = "davmail";
      davmail.ssl.keystoreFile = "/mnt/data/davmail/davmail.p12";
      davmail.ssl.keystorePass = "davmail";
    };
  };

  # Automatically download new youtube videos daily
  systemd.services."update-yt" = {
    serviceConfig = {
      Type = "oneshot";
      User = "mads";
    };
    path = with pkgs; [ yt-dlp ];
    script = ''
      cd "/mnt/share/Mads/Videoklip/yt/"
      for D in */; do
        pushd "''${D}"
        echo "Updating ''${D%/}..."

        if [ -f "download.txt" ]; then
          cat "download.txt" | xargs yt-dlp -f bestvideo+bestaudio --add-metadata --embed-subs --all-subs --download-archive .archive -i
        else
          echo "No download.txt found in ''${D} skipping..."
        fi
        popd
      done
      exit 0
    '';
  };

  systemd.timers."update-yt" = {
    wantedBy = [ "timers.target" ];
    partOf = [ "update-yt.service" ];
    timerConfig = {
      OnCalendar = "daily";
      Unit = "update-yt.service";
    };
  };



  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 config.services.davmail.config.davmail.imapPort config.services.davmail.config.davmail.smtpPort 25566 ];
  networking.firewall.allowedUDPPorts = [ 80 443 config.networking.wireguard.interfaces."wg0".listenPort 25566 ];

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;

    # Prevent silencing of build output
    flags = lib.mkForce [];
  };

  nix.gc = {
    automatic = true;
    options = "-d";
  };
  nix.settings.auto-optimise-store = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

