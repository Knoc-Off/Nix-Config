{ inputs, pkgs, config, libs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
  ];

}
