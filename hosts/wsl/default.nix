{ pkgs, ... }:
{
  imports = [
    ../../modules/wsl
    ../../modules/nixos/locale.nix
    ../../modules/nixos/users.nix
  ];
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
  networking.hostName = "nixos-wsl";

  programs.zsh.enable = true;

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      wget
      git
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "25.11";
}
