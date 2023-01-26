{ inputs, pkgs, unstable, libs, config, ... }:
{
  imports = [
    ./terminal
    ./ssh
    ./gaming
    ./editor
    ./browser
    ./virtualization
    ./media
  ];

  home.packages = with pkgs; [

    # Apps
    unstable.trilium-desktop
    element-desktop

    # CLI Tools
    tealdeer
    fzf
    fd

    # Sound mod
    easyeffects
  ];

  programs.exa.enable = true;
  programs.exa.enableAliases = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userEmail = "nixos-git@knoc.one";
    userName = "knoff";
  };
}
