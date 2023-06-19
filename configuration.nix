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

  pihole = {
    version = "2023.05.2";
    dnsPort = 5353;
    httpPort = 9091;
    customDnses = [
      { ip = "192.168.0.150"; name = "server-mads.lan"; }
    ];
    adlists = [
      "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
      "https://adaway.org/hosts.txt"
      "https://v.firebog.net/hosts/AdguardDNS.txt"
      "https://v.firebog.net/hosts/Admiral.txt"
      "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
      "https://v.firebog.net/hosts/Easylist.txt"
      "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
      "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
      "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
      "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
      "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
      "https://v.firebog.net/hosts/static/w3kbl.txt"
      "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt"
      "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
      "https://someonewhocares.org/hosts/zero/hosts"
      "https://raw.githubusercontent.com/HorusTeknoloji/TR-PhishingList/master/url-lists.txt"
      "https://v.firebog.net/hosts/Easyprivacy.txt"
      "https://v.firebog.net/hosts/Prigent-Ads.txt"
      "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"
      "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
      "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
      "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
      "https://hostfiles.frogeye.fr/multiparty-trackers-hosts.txt"
      "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt"
      "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt"
      "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt"
      "https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt"
      "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt"
      "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
      "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
      "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
      "https://phishing.army/download/phishing_army_blocklist_extended.txt"
      "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
      "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
      "https://urlhaus.abuse.ch/downloads/hostfile/"
      "https://v.firebog.net/hosts/Prigent-Malware.txt"
      "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"
      "https://raw.githubusercontent.com/chadmayfield/my-pihole-blocklists/master/lists/pi_blocklist_porn_all.list"
      "https://v.firebog.net/hosts/Prigent-Crypto.txt"
      "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
    ];
    regexes = [
      "\\.asia$"
      "\\.cn$"
      "(\\.|^)huawei\\.com$"
      "(\\.|^)open-telekom-cloud\\.com$"
      "dbank"
      "hicloud"
    ];
    blacklist = [
      "dubaid.co.uk"
    ];
    whitelist = [
      "connectivitycheck.cbg-app.huawei.com"
      "connectivitycheck.platform.hicloud.com"
      "fonts.gstatic.com"
      "4chan.org"
      "boards.4channel.org"
      "boards.4chan.org"
    ];
  };
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
      ${pkgs.iptables}/bin/iptables -t mangle -A PREROUTING -i wg0 -j MARK --set-mark 0x30
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING ! -o wg0 -m mark --mark 0x30 -j MASQUERADE
    '';

    # This undoes the above command
    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -t mangle -D PREROUTING -i wg0 -j MARK --set-mark 0x30
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING ! -o wg0 -m mark --mark 0x30 -j MASQUERADE
    '';

    # Path to the private key file.
    #
    # Note: The private key can also be included inline via the privateKey option,
    # but this makes the private key world-readable; thus, using privateKeyFile is
    # recommended.
    privateKeyFile = "/mnt/data/wireguard/private-key";

    peers = [
      { # Android
        publicKey = "tOKfgI+4V9iqe2rTPnT/Tjq0+us/H+AV8poHOxmcZEQ=";
        allowedIPs = [ "10.100.0.2/32" ];
      }
    ];
  };


  # List services that you want to enable:

  # Trim ssds weekly
  services.fstrim.enable = true;

  # Enable fail2ban
  services.fail2ban = {
    enable = true;
    ignoreIP = [
      "127.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
    ];
  };

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

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53" "172.17.0.1:53" ];
      server_names = [
        "uncensoreddns-ipv4"
        "uncensoreddns-dk-ipv4"
        "powerdns-doh"
        "dns.watch"
        "moulticast-de-ipv4"
      ];
      block_ipv6 = true;
      ipv6_servers = false;
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
          "allow 192.168.1.0/24;" +
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

      locations."/admin" = {
        proxyPass = "http://127.0.0.1:${toString pihole.httpPort}/admin";
        extraConfig =
          "proxy_set_header Host $host;" +
          "proxy_set_header X-Script-Name /admin;" +
          "proxy_set_header X-Real-IP $remote_addr;" +
          "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;" +
          "proxy_hide_header X-Frame-Options;" +
          "proxy_set_header X-Frame-Options \"SAMEORIGIN\";"
          ;
      };
    };
  };

  virtualisation.oci-containers.backend = "docker";
  virtualisation.docker.autoPrune.enable = true;

  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:${pihole.version}";
    ports = [
      "${toString pihole.dnsPort}:53/udp"
      "${toString pihole.dnsPort}:53/tcp"
      "${toString pihole.httpPort}:80/tcp"
    ];
    environment = {
      TZ = config.time.timeZone;
      WEB_PORT = "80";
      WEBPASSWORD = "toor";
      #VIRTUAL_HOST = "192.168.1.114";
      PIHOLE_DNS_ = "172.17.0.1";
      REV_SERVER = "true";
      REV_SERVER_DOMAIN = "router.lan";
      REV_SERVER_TARGET = "192.168.1.1";
      REV_SERVER_CIDR = "192.168.1.0/16";
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
    ${builtins.foldl' (x: y: x + "docker exec pihole pihole -a addcustomdns \"" + y.ip + "\" \"" + y.name + "\" false\n") ""  pihole.customDnses}

    # Add adlists
    ${builtins.foldl' (x: y: x + "docker exec pihole pihole -a adlist add \"" + y + "\"\n") "" pihole.adlists}

    # Add regexes
    ${builtins.foldl' (x: y: x + "docker exec pihole pihole --regex '" + y + "'\n") "" pihole.regexes}

    # Add blacklisted domains
    ${builtins.foldl' (x: y: x + "docker exec pihole pihole -b \"" + y + "\"\n") "" pihole.blacklist}

    # Add whitelisted domains
    ${builtins.foldl' (x: y: x + "docker exec pihole pihole -w \"" + y + "\"\n") "" pihole.whitelist}

    # Apply changes
    docker exec pihole pihole -g
  '';

  services.minecraft-ftb-server = {
    enable = true;
    dataDir = "/mnt/data/minecraft/FeedTheBeast";
    openFirewall = true;
    serverExecutable = "/mnt/data/minecraft/FeedTheBeast/FTBServer-1.7.10-1614.jar";
    jvmOpts = "-server -Xms512M -Xmx2048M -XX:PermSize=256M -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm -Dfml.queryResult=confirm";
    javaPackage = pkgs.jdk8;
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

  # Hardening davmail
  systemd.services.davmail.serviceConfig = {
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
    RemoveIPC = true;
    RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    SystemCallArchitectures = "native";
    SystemCallFilter = "@system-service ~@privileged";
    SystemCallErrorNumber = "EPERM";
    UMask = "0077";
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
  networking.firewall.allowedTCPPorts = [ 53 80 443 pihole.dnsPort config.services.davmail.config.davmail.imapPort config.services.davmail.config.davmail.smtpPort ];
  networking.firewall.allowedUDPPorts = [ 53 80 443 pihole.dnsPort 51820 ];
  #networking.firewall.checkReversePath = "loose";

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
  system.stateVersion = "23.05"; # Did you read the comment?

}

