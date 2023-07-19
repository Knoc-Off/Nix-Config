{ inputs, lib, config, pkgs, ... }: {

  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
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

  # Figure out how to delete users...
  users.users = {
    niko = {
      shell = pkgs.zsh;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    };
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
