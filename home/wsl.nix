{ ... }:
{
  imports = [
    ./common.nix

    ../modules/home/packages/wsl.nix
  ];

  home.sessionVariables = {
    BROWSER = "/mnt/c/Windows/explorer.exe";
  };
}
