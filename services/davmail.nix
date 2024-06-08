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

  networking.firewall.allowedUDPPorts = [config.networking.wg-quick.interfaces."wg0".listenPort];
}
