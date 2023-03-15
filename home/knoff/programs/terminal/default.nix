{ pkgs, libs, config, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./zsh.nix
    ./programs.nix
  ];

}
