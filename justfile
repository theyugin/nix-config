default:
  just --list --unsorted

rebuild TYPE="switch":
    sudo nixos-rebuild {{TYPE}} --flake .#

update:
    nix flake update

gc:
    nix store gc
