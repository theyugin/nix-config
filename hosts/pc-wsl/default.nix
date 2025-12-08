{ pkgs, ... }:
{
  imports = [
    ../common

    ../../modules/wsl
  ];
  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
    users.yugin = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
  };
  networking.hostName = "pc-wsl";

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

}
