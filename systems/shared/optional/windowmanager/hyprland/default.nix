{ pkgs, config, lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];
}
