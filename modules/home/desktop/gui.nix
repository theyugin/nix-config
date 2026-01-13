{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xarchiver

    discord
    telegram-desktop

    spotify
    transmission_4-gtk
  ];
}
