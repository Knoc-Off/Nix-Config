{ pkgs, ... }:
{
  # Enable sway through home-manager
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = { };
  };


}
