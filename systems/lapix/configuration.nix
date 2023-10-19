{ inputs, lib, config, pkgs, ... }: {

  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
  ];



  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.support32Bit = true;




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


  programs.light.enable = true; # brightness?

  services.dbus.enable = true;

  users.users = {
    knoff = {
      shell = pkgs.zsh;
      isNormalUser = true;
      initialPassword = "knoff";
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      packages = with pkgs;
        [
          vulkan-tools
        ];

    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
