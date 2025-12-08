{ pkgs, ... }:
{
  # not sure why but nerd font needs to be installed separately
  home.packages = [
    pkgs.nerd-fonts.iosevka-term
  ];

  stylix = {
    enable = true;
    polarity = "dark";

    targets = {
      gtk.enable = true;
      gtk.flatpakSupport.enable = true;
      fontconfig.enable = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.iosevka-term;
        name = "IosevkaTerm NF";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        terminal = 13;
      };
    };

    icons = {
      enable = true;
      dark = "Gruvbox-Plus-Dark";
      light = "Gruvbox-Plus-Light";
      package = (
        pkgs.gruvbox-plus-icons.override {
          folder-color = "green";
        }
      );
    };
  };

  gtk.enable = true;
}
