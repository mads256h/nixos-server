# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  # Root

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/258ba2f6-9932-47e3-9b34-e11cc747e127";
      fsType = "btrfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/cfb6f323-2397-4508-8f65-e6ac4e3aeea4"; }
    ];

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "256g";
  };


  # Share

  fileSystems."/mnt/share" =
    { device = "/dev/disk/by-uuid/51a551fa-d1ba-4c83-8ad5-bfcab4496f29";
      fsType = "btrfs";
      options = [ "defaults" "noexec" "nodev" "nosuid" ];
    };


  # Data

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/acb26053-df19-42f5-90b7-9e29079db53c";
      fsType = "ext4";
      options = [ "defaults" "nodev" "nosuid" "errors=remount-ro" ];
    };

  services.btrfs.autoScrub.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
