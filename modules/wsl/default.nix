{ ... }:
{
  wsl = {
    enable = true;
    defaultUser = "yugin";
    startMenuLaunchers = true;

    docker-native.enable = false;

    interop.enabled = true;
  };
}
