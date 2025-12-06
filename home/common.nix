{ ... }:
{
  imports = [
    ../modules/home/programs/git.nix
    ../modules/home/programs/zsh.nix
    ../modules/home/programs/neovim.nix
    ../modules/home/programs/vscode.nix
    ../modules/home/packages/cli.nix
    ../modules/home/packages/utils.nix
  ];

  home = {
    username = "yugin";
    homeDirectory = "/home/yugin";
    stateVersion = "25.11";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
