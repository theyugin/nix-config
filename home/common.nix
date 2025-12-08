{ config, ... }:
{
  imports = [
    ./user-config.nix
    ../modules/home/cli
  ];

  config = {
    home = {
      username = config.userConfig.userName;
      homeDirectory = config.userConfig.homeDirectory;
      stateVersion = "25.11";
    };
  };
}
