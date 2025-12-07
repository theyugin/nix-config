{ pkgs, ... }:
{
  home.packages = with pkgs; [
    foot
    
    mako
    
    xarchiver
    hyprshot
    swaybg
    wl-clipboard
  ];
}
