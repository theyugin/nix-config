{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wget
    curl
    
    fastfetch
    
    tree
    fd
    ripgrep
    htop
  ];
}
