{ inputs, bled, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    bled.lutris
  ];

  #home.sessionVariables = {
  #  LUTRIS_SKIP_INIT = true;
  #};
}
