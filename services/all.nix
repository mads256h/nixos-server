# vim: ts=2 sw=2 et
{ config, lib, pkgs, ... }:

{
  imports = 
    [
      ./davmail.nix
      ./monitoring.nix
      ./nfs.nix
      ./nginx.nix
      ./radicale.nix
      ./wireguard.nix
      ./your_spotify.nix
    ];
}
