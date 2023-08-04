{ pkgs, config, ... }:
let
  myusername = "knoff";

in
{

  services = {
    syncthing = {
      enable = true;
      user = myusername;
      dataDir = "/home/${myusername}/Documents"; # Default folder for new synced folders
      configDir = "/home/${myusername}/Documents/.config/syncthing"; # Folder for Syncthing's settings and keys

    };
  };





}
