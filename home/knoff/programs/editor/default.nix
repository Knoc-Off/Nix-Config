{ pkgs, inputs, libs, config, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./neovim
  ];

}
