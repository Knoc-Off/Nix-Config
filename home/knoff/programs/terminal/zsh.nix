/*
    Z shell configuration
    Package installation for Z shell
    oh-my-zsh configuration
    Z shell custom aliases
    Z shell initialization scripts
*/
#NixOS, Z shell, shell configuration, package installation, oh-my-zsh, custom aliases, initialization scripts.
{ lib, pkgs, ... }:
{

    home.packages = with pkgs; [
      chroma # Required for colorize...
      imagemagick # Required for catomg
      thefuck # If you forget sudo or something
      qrencode
      #starship
    ];

    programs.starship = {
      enable = false;
      enableZshIntegration = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$localip"
          "$directory"
          #"$haskell"
          #"$nix_shell"
          #"$memory_usage"
          "$custom"
          #"$sudo"
          "$cmd_duration"
          "$line_break"
          #"$jobs"
          #"$battery"
          #"$time"
          #"$status"
          #"$os"
          #"$container"
          #"$shell"
          "$character"
        ];

        add_newline = false;
      };
    };

    programs.mcfly = {
      enable = true;
      enableZshIntegration = true;
      keyScheme = "vim";
    };

    programs.zsh = {
      enable = true;
      sessionVariables = {
        ZSH_COLORIZE_TOOL = "chroma";
      };
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
        "colorize"
        "extract"
        "fancy-ctrl-z"
        "fd"
        "mosh"
      ];
      shellAliases = {
        rm = ''echo "use trash-cli instead"'';
        remove = ''/usr/bin/env rm'';
        tmux = "TERM=screen-256color tmux";
        sshk = "kitty +kitten ssh";
      };
      initExtra = builtins.readFile ../configs/zshrc.sh;
    };
}
