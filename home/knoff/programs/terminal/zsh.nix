{ lib, pkgs, config, ... }:
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
    enableAutosuggestions = true;


    dirHashes = {
      docs = "$HOME/Documents";
      dl = "$HOME/Downloads";

    };


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


    # append text to end of read file
    initExtra =
      builtins.readFile
        ../configs/zshrc.sh +
      ''
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#${config.colorScheme.colors.base05}"

        # if file exists, export the variable export OPENAI_API_KEY=
        if [ -f /etc/secrets/gpt/secret ]; then
          export OPENAI_API_KEY=$(cat /etc/secrets/gpt/secret)

        fi


      '';

    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#${config.colorScheme.colors.base02},bg=#${config.colorScheme.colors.base02},bold"
  };
}
