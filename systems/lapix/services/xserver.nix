{ inputs, pkgs, libs, ... }:
{
  # Configure keymap in X11
  services.xserver.layout = "us";
  # touchpad
  services.xserver.libinput.enable = true;



}
