{ inputs, ... }: {
  imports = [
    ../shared/systems-common
    ../shared/optional/audio
    ../shared/optional/filemanager.nix

    #../shared/optional/windowmanager/hyprland
    ../shared/optional/windowmanager/gnome.nix
    #../shared/optional/greetd.nix
    #./vm.nix


    ../shared/optional/zsh.nix

    ./networking
    ./system
    ./services
    ./configuration.nix

    ./modules/default.nix
  ];
}
