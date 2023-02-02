{inputs, lib, pkgs, ... }:
{
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-console
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    #gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-weather
    gnome-contacts
  ]);
}
