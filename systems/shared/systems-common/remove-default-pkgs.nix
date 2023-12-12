{ inputs, pkgs, lib, ... }:
{
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;
  documentation.nixos.enable = false;
}
