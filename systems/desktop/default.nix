{ inputs, ... }: {
  imports = [
    ../shared/systems-common
    ../shared/optional/audio
    ../shared/optional/windowmanager
    ./networking
    ./system
    ./services
    ./configuration.nix
    ./modules/default.nix
  ];
}
