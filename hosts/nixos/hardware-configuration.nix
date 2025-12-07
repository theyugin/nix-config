{
  config,
  lib,
  modulesPath,
  ...
}:

let
  EFI_PART_LABEL = "PCEFI";
  LUKS_PART_LABEL = "PCNIXOS";
  LUKS_KEY_LABEL = "CRYPTKEY";
  ROOT_LVM_PART_LABEL = "PCNIXOSROOT";
  SWAP_LVM_PART_LABEL = "PCNIXOSSWAP";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [
        "dm-snapshot"
        "cryptd"
      ];

      systemd.enable = true;
      luks.devices."crypted" = {
        device = "/dev/disk/by-label/${LUKS_PART_LABEL}";
        keyFile = "/dev/disk/by-label/${LUKS_KEY_LABEL}";
        keyFileTimeout = 5;
      };
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/${ROOT_LVM_PART_LABEL}";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/${EFI_PART_LABEL}";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-label/${SWAP_LVM_PART_LABEL}"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
