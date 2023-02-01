#NixOS, home-manager, system configuration, package installation, program enablement, system options.
# This is your home-manager configuration file

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    # You can also split up your configuration and import pieces of it here:
    ./programs # This installs some packages, and imports all of the configured packages.
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (pkg: true);
    };
  };

  home = {
    username = "knoff";
    homeDirectory = "/home/knoff";
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
