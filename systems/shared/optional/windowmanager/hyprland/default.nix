{ pkgs, config, lib, ... }:
{
  imports = [
    ./hyprland.nix
    #./waybar.nix
  ];
  environment.systemPackages = with pkgs; [
    hyprpaper
    swaylock
    swayidle
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security.pam.services.swaylock = {};
}
