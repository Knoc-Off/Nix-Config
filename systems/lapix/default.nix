{ inputs, ... }: {
  imports = [
    ../shared/systems-common
    ./networking
    ./system
    ./services
    ./configuration.nix
    
    ./modules/default.nix

    ../shared/optional/windowmanager
  ];
}
