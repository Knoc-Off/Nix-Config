{ nix-colors, lib, config, pkgs, ... }:
{
  imports = [
    ./theme.nix
  ];
  services.mako = {
    enable = true;
    #iconPath = "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark";
    #font = "${config.fontProfiles.regular.family} 12";

    padding = "10,20";
    anchor = "top-left";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "#${config.colorScheme.colors.base02}";
    borderColor = "#${config.colorScheme.colors.base05}";
    textColor = "#${config.colorScheme.colors.base07}";
  };
  #programs.mako.enable = true;
}
