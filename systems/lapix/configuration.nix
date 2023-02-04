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
    git
    trashy
    sops
  ];

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
