{ pkgs, inputs, config, ... }:
{
  imports = [
    ./xserver.nix
    ./logind.nix
    ./earlyoom.nix
  ];






}
