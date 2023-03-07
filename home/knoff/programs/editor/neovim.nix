# NixOS, Neovim, text editor configuration, plugins, custom configuration options
{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    colorschemes.base16 = {
      enable = true; 
      colorscheme = "ia-dark";
    };
    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      expandtab = true;
      shiftwidth = 2;        # Tab width should be 2
      tabstop=2;
      clipboard = "unnamed";
      mouse = ""; # mouse should be able to select, not move cursor
      undofile = true;
      so = 5; # keeps cursor center not sure if i like.
    };

    maps = {
      #normalVisualOp.";" = ":"; # Same as noremap ; :
      # vnoremap . :normal .<CR>

      visual."." = {
        silent = true;
        action = ":normal .<CR>";
      };

      #normal."<C-M-u> j" = { # :nnoremap <C-M-u> j<C-e>
        #silent = true;
        #action = "<C-e>";
      #}; 
    }; 

    extraConfigLua = 
    ''
      local vim = vim
      local opt = vim.opt
      local api = vim.api
      require("transparent").setup({
        enable = true, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be cleared
          -- In particular, when you set it to 'all', that means all available groups
          -- example of akinsho/nvim-bufferline.lua
          "BufferLineTabClose",
          "BufferlineBufferSelected",
          "BufferLineFill",
          "BufferLineBackground",
          "BufferLineSeparator",
          "BufferLineIndicatorSelected",
        },
        exclude = {}, -- table: groups you don't want to clear
        ignore_linked_group = true, -- boolean: don't clear a group that links to another group
      })


      opt.foldmethod = "expr"
      opt.foldexpr = "nvim_treesitter#foldexpr()"

      function _G.custom_fold_text()
        local line = vim.fn.getline(vim.v.foldstart)
        local line_count = vim.v.foldend - vim.v.foldstart + 1
      return " ⚡ " .. line .. ": " .. line_count .. " lines"
      end

      vim.opt.foldtext = custom_fold_text()
      vim.opt.fillchars = { eob = "-", fold = " " }
      vim.opt.viewoptions:remove("options")


      opt.foldtext = 'v:lua.custom_fold_text()'


      -- vim.cmd("colorscheme kanagawa")

    '';
    autoCmd = [
      {
        event = [  "BufReadPost" "FileReadPost" "BufEnter" "BufWinEnter" ];
        pattern = [ "*" ];
        command = "normal zR";
      }
    ];
		plugins = { 
			nix.enable = true;
      treesitter = {
        enable = true;
        folding = true;
        indent = true;

        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.passthru.builtGrammars; [
          bash
          c
          html
          help # neovim help
          javascript
          latex
          lua
          nix
          norg
          python
          rust
        ];
      };
			lsp = {
			  servers = { 
          rust-analyzer.enable = true;
          lua-ls.enable = true;
					rnix-lsp = {
						enable = true;
					};
				};
			};
		};
    extraPlugins = with pkgs.vimPlugins; [
      kanagawa-nvim
      nvim-colorizer-lua
      vim-terraform

      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "nvim-transparent";
        version = "4c3c392f285378e606d154bee393b6b3dd18059c";
        src = pkgs.fetchFromGitHub {
          owner = "xiyaowong";
          repo = "nvim-transparent";
          rev = version;
          sha256 = "sha256-XxccI1V/u0k7jHhize7M0kLdmelBkqll4Dxmd8aBnbE=";
        };
      })
    ];
  };
}
