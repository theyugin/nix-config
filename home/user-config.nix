{ lib, ... }:
{
  options.userConfig = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "The username of the user.";
    };
    homeDirectory = lib.mkOption {
      type = lib.types.str;
      description = "The home directory of the user.";
    };
    gitUserName = lib.mkOption {
      type = lib.types.str;
      description = "The git user name.";
    };
    gitUserEmail = lib.mkOption {
      type = lib.types.str;
      description = "The git user email.";
    };
  };
}
