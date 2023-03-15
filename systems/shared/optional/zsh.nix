{ pkgs, ... }:
{
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
        "extract"
        "fancy-ctrl-z"
        "fd"
        "mosh"
      ];
      shellAliases = {
        rm = ''echo "use trash-cli instead"'';
        remove = "/usr/bin/env rm";
        tmux = "TERM=screen-256color tmux";
      };
      initExtra = builtins.readFile ./configs/zshrc.sh;
    };
}
