{ inputs, lib, config, pkgs, ... }: {

  imports = [
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

  ## Desktop Enviroment
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # should be moved elsewhere
  programs.steam = {
    enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    gnomeExtensions.tweaks-in-system-menu
    vim
    wget
    curl
    #unstable.git
    git
    trashy
    sops
    alacritty
  ];

  #users.users = {
  #  niko = {
  #    shell = pkgs.zsh;
  #    isNormalUser = true;
  #    openssh.authorizedKeys.keys = [
  #    ];
  #    extraGroups = [ "wheel" "networkmanager" "audio" ];
  #  };
  #};

  users.users = {
    knoff = {
      shell = pkgs.zsh;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
