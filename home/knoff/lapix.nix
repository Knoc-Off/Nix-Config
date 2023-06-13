#NixOS, home-manager, system configuration, package installation, program enablement, system options.
{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./programs
    ./services
    ./desktop
    ./enviroment.nix
  ];

  nixpkgs = {
    overlays = [
      #inputs.nixneovimplugins.overlays.default
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
