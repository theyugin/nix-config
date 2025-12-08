{ config, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = config.userConfig.gitUserName;
      user.email = config.userConfig.gitUserEmail;
    };
  };
}
