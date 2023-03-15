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
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        #serif = [ "Vazir" "Ubuntu" ];
        #sansSerif = [ "Vazir" "Ubuntu" ];
        monospace = [ "FiraCode" ];
      };
    };
  };

  programs.steam = {
    enable = true;
  };


  # Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    trashy

    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    xdg-desktop-portal-wlr # Screen Rec.

    swaylock # Screen-locking?
    swayidle

    slurp # screenshot functionality
    grim
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

    mako # Notifications
  ];

  programs.light.enable = true; # brightness? 

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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
