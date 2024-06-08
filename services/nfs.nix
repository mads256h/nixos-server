# vim: ts=2 sw=2 et
{ config, lib, pkgs, ... }:

{
  services.nfs.server = {
    enable = true;
    exports = ''
      /export/share  10.0.1.0/24(rw)
    '';
    createMountPoints = true;
  };

  # Keep things inside the export directory
  fileSystems."/export/share" =
    { device = "/mnt/share";
      options = [ "bind" ];
    };

  # Allow through firewall
  networking.firewall.interfaces."enp1s0" = {
    allowedTCPPorts = [ 2049 ];
    allowedUDPPorts = [ 2049 ];
  };
}
