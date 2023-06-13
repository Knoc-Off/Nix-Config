{ inputs, pkgs, lib, ... }:
{
  services.xserver =
    {
      enable = true;
      videoDrivers = [ "intel" ];
    };

  imports = [
    inputs.hyprland.nixosModules.default
    {
      programs.hyprland = {
        enable = true;
        xwayland = {
          hidpi = true;
        };

      };
    }
  ];

  #  programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #
  #  programs.hyprland = {
  #    enable = true;
  #
  #    # default options, you don't need to set them
  #    #package = hyprland.packages.${pkgs.system}.default;
  #
  #    #xwayland = {
  #    #enable = true;
  #    #hidpi = false;
  #    #};
  #
  #    nvidiaPatches = false;
  #  };



}
