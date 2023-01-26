{ inputs, pkgs, libs, config, ... }:
{
  imports = [
    #./steam.nix
    ./lutris.nix

  ];
  home.packages =  [
    # Minecraft Launcher
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher

  ];

}
