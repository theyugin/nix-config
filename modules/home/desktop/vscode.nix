{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.jdinhlife.gruvbox
        pkgs.vscode-extensions.vscodevim.vim
      ];
      userSettings = {
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
    };
  };
}
