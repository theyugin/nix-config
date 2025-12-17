{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.default
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };
      lualine = {
        enable = true;
        settings = {
          options = {
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
        };
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
        };
      };
    };
    opts = {
      clipboard = "unnamedplus";
      signcolumn = "yes";
      relativenumber = true;
      number = true;

      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;

      winborder = "single";
      wrap = false;
    };
  };
}
