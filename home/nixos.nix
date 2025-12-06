{ ... }:
{
  imports = [
    ./common.nix
    
    ../modules/home/packages/gui.nix
    ../modules/home/packages/wayland.nix

    ../modules/home/programs/hyprland.nix
    ../modules/home/programs/foot.nix
    
    ../modules/home/themes/stylix.nix
  ];
}
