# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixpkgs/nixos/modules/profiles/minimal.nix>
      <nixpkgs/nixos/modules/profiles/hardened.nix>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  security.lockKernelModules = false;
  security.protectKernelImage = false;

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
  networking.hostName = "server-mads"; # Define your hostname.

  networking.nameservers = [
    "192.168.1.114"
    "8.8.8.8"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "dk";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };


  users = {
    mutableUsers = false;
    users."root" = {
      password = "toor";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeCSo+ztID41jlKZIy++UdhacKy0I4A/qqCWBBU1RP1NnoKdMcFqXyKJFLsltpuTuWKf9WnTgT+KCidMR8Foysdic5i7lGy4TMP8sa+RqNVUhLM93fM7YHrmGZHVbrg0rNVKnbFv/0lDZLiyp/l7B7vmuBtE3pCYW7nbFvoje+5pWDrpFL16qAFgIM5i3Ly9adkkObVw1Nz4tkjS5i6AJQc5ZYFzipVl5XU9NHdxg2SQrXokeX59AEN0UaUuUm/Ft0Mxyu01MyuHcqLK/b2netJrF/THj4bYu629IqDe+FT+APihhlvp40WI8Py9/dl6OSzB35XaQ1X60WBfqgLFgu6vM3NgItzVjRjb72paJ6YdVkhMJZezMdJxKfxrLXJPTLQELhETB0mFtM4tMb2Mh43Jp3oWPLg9ZtFEcKlafAWuHpbRHRsjD58UawrB3M/uq8+T+jmlh9CSRdcjIlf+Oz1AANk2rU/voUE8jhzeRLOwLNEahAb1d5mBLklOK9351gzRmYJxPuggdR0EiRchE59JiSUAmGxky0bHyOfOoqdLkd5cIxmv8FTqY2BXvHJhe8DpWaxYt/rR9ckTiNyJ+XgkvpGMDbwpoJBh1ELmZ2Iy3mg/r2Gmw83eK4w+q+Wzz3Nhm8flVikL+DAwPnfV8dObzyC62LNTWos1Gb+lY7Aw== mads@DESKTOP-MADS"
      ];
    };

    users."mads" = {
      isNormalUser = true;
      uid = 1000;
      password = "toor";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeCSo+ztID41jlKZIy++UdhacKy0I4A/qqCWBBU1RP1NnoKdMcFqXyKJFLsltpuTuWKf9WnTgT+KCidMR8Foysdic5i7lGy4TMP8sa+RqNVUhLM93fM7YHrmGZHVbrg0rNVKnbFv/0lDZLiyp/l7B7vmuBtE3pCYW7nbFvoje+5pWDrpFL16qAFgIM5i3Ly9adkkObVw1Nz4tkjS5i6AJQc5ZYFzipVl5XU9NHdxg2SQrXokeX59AEN0UaUuUm/Ft0Mxyu01MyuHcqLK/b2netJrF/THj4bYu629IqDe+FT+APihhlvp40WI8Py9/dl6OSzB35XaQ1X60WBfqgLFgu6vM3NgItzVjRjb72paJ6YdVkhMJZezMdJxKfxrLXJPTLQELhETB0mFtM4tMb2Mh43Jp3oWPLg9ZtFEcKlafAWuHpbRHRsjD58UawrB3M/uq8+T+jmlh9CSRdcjIlf+Oz1AANk2rU/voUE8jhzeRLOwLNEahAb1d5mBLklOK9351gzRmYJxPuggdR0EiRchE59JiSUAmGxky0bHyOfOoqdLkd5cIxmv8FTqY2BXvHJhe8DpWaxYt/rR9ckTiNyJ+XgkvpGMDbwpoJBh1ELmZ2Iy3mg/r2Gmw83eK4w+q+Wzz3Nhm8flVikL+DAwPnfV8dObzyC62LNTWos1Gb+lY7Aw== mads@DESKTOP-MADS"
      ];
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
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
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

    virtualHosts."cocalc.madsmogensen.dk" =  {
      enableACME = true;
      forceSSL = true;
      basicAuthFile = "/mnt/data/cocalc-proxy/htpasswd";
      locations."/" = {
        proxyPass = "https://localhost:9090/";
	proxyWebsockets = true;
        extraConfig =
	  "proxy_set_header Host $host;" +
          "proxy_ssl_server_name on;" +
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
    };
  };

  virtualisation.oci-containers.backend = "podman";
  #virtualisation.docker.autoPrune.enable = true;
  virtualisation.oci-containers.containers.cocalc = {
    image = "sagemathinc/cocalc:1edac8a13874";
    volumes = [
      "/mnt/data/cocalc:/projects"
    ];
    ports = [
      "9090:443/udp"
      "9090:443/tcp"
    ];
  };

  # Wait for the container to be in the podman ps output and then install the packages texlive-full and python-pygments
  systemd.services."podman-cocalc".postStart = ''
    while ! podman ps | grep cocalc; do
      sleep 10s
      echo "Waiting on container";
    done

    podman exec cocalc apt-get install -y texlive-full
    podman exec cocalc apt-get install -y python-pygments
  '';


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 51820 ];
  #networking.firewall.checkReversePath = "loose";

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  nix.gc = {
    automatic = true;
    options = "-d";
  };
  nix.autoOptimiseStore = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?

}

