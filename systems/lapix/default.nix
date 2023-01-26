{ inputs, ... }: {
  imports = [
    ../shared/systems-common
    ./networking
    ./system
    ./services
    ./configuration.nix
    
    ./modules/default.nix

  ];



  #sops.secrets.lapix-password = {
    #sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  #};

}
