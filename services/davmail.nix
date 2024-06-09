# vim: ts=2 sw=2 et
{ config, lib, pkgs, ... }:

{
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

  networking.firewall.allowedTCPPorts = [
    config.services.davmail.config.davmail.imapPort
    config.services.davmail.config.davmail.smtpPort
  ];

  # Hack: No xlibs pls
  nixpkgs.overlays = [
    (final: prev:
    {
      davmail = prev.davmail.override { zulu = pkgs.jdk21_headless; gtk3 = pkgs.coreutils; libXtst = pkgs.coreutils; };
    })
  ];
}
