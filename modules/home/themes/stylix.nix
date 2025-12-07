{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";

    targets = {
      gtk.enable = true;
      gtk.flatpakSupport.enable = true;
      firefox.enable = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
      };
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      package = (
        pkgs.gruvbox-plus-icons.override {
          folder-color = "green";
        }
      );
      name = "Gruvbox-Plus-Dark";
    };
  };
}
