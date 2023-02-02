{inputs, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    ripgrep
  ];
}
