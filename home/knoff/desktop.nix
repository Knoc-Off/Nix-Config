{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./programs
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
