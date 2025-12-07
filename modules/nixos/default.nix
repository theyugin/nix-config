{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "pc";
  };

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
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
    printing.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    zsh.enable = true;
    
    firefox.enable = true;
    
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

  environment = {
    systemPackages = with pkgs; [
      wget
      git
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts.iosevka-term
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "IosevkaTerm NF" ];
      };
    };
  };
}
