{ lib, pkgs, config, ...}:
{
  programs.fuzzel = { 
    enable = true;
    settings = lib.mkAfter {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        font = "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.terminal}";
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
  stylix.targets.fuzzel = {
    enable = true;
    fonts.enable = false;
  };
}
