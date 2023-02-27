{ inputs, lib, config, pkgs, ... }: {

  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
  ];

  services.flatpak.enable = true;

  services.qemuGuest.enable = true;
  virtualisation.libvirtd.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      hack-font
      noto-fonts-emoji
    ];
  };

  programs.steam = {
    enable = true;
  };


  # Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    #unstable.git
    libevdev
    git
    trashy

    dracula-theme # gtk theme
    xdg-desktop-portal-wlr

    swaylock # Screen-locking?
    swayidle

    slurp # screenshot functionality
    grim
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

    mako # Notifications

    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors

  ];


  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  users.users = {
    knoff = {
      shell = pkgs.zsh;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    };
  };
  programs.light.enable = true; # brightness? 

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
