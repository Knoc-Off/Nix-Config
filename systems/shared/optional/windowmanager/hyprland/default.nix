{ pkgs, config, lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];
}
