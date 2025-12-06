{ pkgs, ... }:
{
  home.packages = with pkgs; [
    foot
    
    mako
    
    xarchiver
    hyprshot
    swaybg
    walker
    wl-clipboard
  ];
}
