{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xarchiver
    hyprshot
    swaybg
    wl-clipboard

    discord
    telegram-desktop

    spotify
    playerctl
  ];
}
