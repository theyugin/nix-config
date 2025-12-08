{
  userConfig = {
    userName = "yugin";
    homeDirectory = "/home/yugin";
    gitUserName = "theyugin";
    gitUserEmail = "theyugin@gmail.com";
  };

  imports = [
    ../../common.nix
    ../../../modules/home/desktop
  ];
}
