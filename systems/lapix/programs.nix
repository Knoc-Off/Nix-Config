{ inputs, lib, config, pkgs, ... }: {

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    trashy

    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme # default gnome cursors
    #xdg-desktop-portal-wlr # Screen Rec.

    swaylock # Screen-locking?
    swayidle

    slurp # screenshot functionality
    grim
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

    mako # Notifications
  ];
}
