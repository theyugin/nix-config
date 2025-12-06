{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "25.11";
}
