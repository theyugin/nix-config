{
  imports = [
    ../../common.nix
    ../../../modules/home/desktop
  ];

  userConfig = {
    userName = "yugin";
    homeDirectory = "/home/yugin";
    gitUserName = "theyugin";
    gitUserEmail = "theyugin@gmail.com";
  };
}
