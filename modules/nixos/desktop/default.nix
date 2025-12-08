{ pkgs, ... }:
{
  imports = [
    ../base
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    networkmanager.enable = true;
  };

  users = {
    users.yugin = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    waybar.enable = true;
  };
}
