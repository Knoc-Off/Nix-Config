{ inputs, pkgs, lib, ... }:
{

  services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  imports = [
    inputs.hyprland.nixosModules.default
      {programs.hyprland.enable = true;}
  ];

  (inputs.hyprland.packages.${pkgs.default}.default.override {
    enableXWayland = true;
    hidpiXWayland = true;
    nvidiaPatches = false;
  })



}
