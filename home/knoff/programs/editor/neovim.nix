# NixOS, Neovim, text editor configuration, plugins, custom configuration options
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfig =
      ''
        set clipboard=unnamedplus
        set autoindent
        set expandtab
        set tabstop=2
        set shiftwidth=2
        set relativenumber
        set number
        set undofile
        set mouse
      '';
    plugins = with pkgs.vimPlugins; [
      direnv-vim # For .direnv + nixshell
      yankring
      vim-nix
      nvim-treesitter
      nvim-cmp
      fzf-vim
      fzfWrapper
      haskell-vim
      vim-lua
      rust-vim

      nvim-cmp

      vim-markdown
      vim-json
      neoformat
      #vim-lsp
      #nvim-lspconfig
    ];
  };
}
