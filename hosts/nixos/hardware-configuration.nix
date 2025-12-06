{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

let
  EFI_PART_UUID = "BA4D-3A55";
  LUKS_PART_UUID = "644ae2e0-eec7-4081-9bdc-36ce78d54345";
  LUKS_KEY_UUID = "asdf";
  ROOT_LVM_PART_UUID = "ae9f98b6-5cd7-4df0-8e17-4934e851cd4a";
  SWAP_LVM_PART_UUID = "ab6df6fb-56ad-4db6-a326-fe20ac88c6a8";
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
        device = "/dev/disk/by-uuid/${LUKS_PART_UUID}";
        keyFile = "/dev/disk/by-uuid/${LUKS_KEY_UUID}";
        keyFileTimeout = 5;
      };
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/${ROOT_LVM_PART_UUID}";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/${EFI_PART_UUID}";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/${SWAP_LVM_PART_UUID}"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
