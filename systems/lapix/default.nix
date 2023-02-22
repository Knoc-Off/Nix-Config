{ inputs, ... }: {
  imports = [
    ../shared/systems-common
    ../shared/optional/audio
    ./networking
    ./system
    ./services
    ./configuration.nix
    
    ./modules/default.nix

    ../shared/optional/windowmanager
  ];
}
