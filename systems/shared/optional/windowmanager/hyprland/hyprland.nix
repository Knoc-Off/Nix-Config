{ inputs, pkgs, lib, ... }:
{

  services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  imports = [
    inputs.hyprland.nixosModules.default
    {
      programs.hyprland = {
        enable = true;
        #enableXWayland = true;
        #hidpiXWayland = true;
        #nvidiaPatches = false;
      };
    }
  ];




}
