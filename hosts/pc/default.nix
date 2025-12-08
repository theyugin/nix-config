{
  imports = [
    ../common

    ./hardware-configuration.nix

    ../../modules/nixos/desktop
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "pc";

  system.stateVersion = "25.11";
}
