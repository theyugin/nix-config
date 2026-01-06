{ pkgs, ... }:
{
  programs.zed-editor = {
    extraPackages = with pkgs; [
      nixd
    ];
    enable = true;
  };
}
