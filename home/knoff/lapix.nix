#NixOS, home-manager, system configuration, package installation, program enablement, system options.
{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./programs
    ./services
    ./desktop
    ./desktop/hyprland
    ./enviroment.nix

    # !!
    ./desktop/sway.nix
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      #outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (pkg: true);
    };
  };

  home = {
    username = "knoff";
    homeDirectory = "/home/knoff";
#    sessionVariables = {
#      # !! Should remove/reposition
#      NIXPKGS_ALLOW_UNFREE = "1";
#    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.adwaita-qt;
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

}
