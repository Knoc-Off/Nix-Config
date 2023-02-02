{ pkgs, libs, config, ... }:
{
  imports = [
    ./alacritty.nix
    ./zsh.nix
    ./programs.nix
  ];

}
