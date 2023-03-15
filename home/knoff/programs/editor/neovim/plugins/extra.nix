{pkgs, config, lib, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
        nui-nvim
        (pkgs.vimUtils.buildVimPlugin rec {
         pname = "CodeGpt";
         version = "96ec57766c6d2133d1b921daffca651c3c7a3541";
         src = pkgs.fetchFromGitHub {
         owner = "dpayne";
         repo = "CodeGPT.nvim";
         rev = version;
         sha256 = "sha256-stsXKajTDvlFzjDzbssLWulFrAMFQO7FLCZZAg7x4Dg=";
         };
       })

    (pkgs.vimUtils.buildVimPlugin rec {
     pname = "darkplus";
     version = "1826879d9cb14e5d93cd142d19f02b23840408a6";
     src = pkgs.fetchFromGitHub {
     owner = "LunarVim";
     repo = "darkplus.nvim";
     rev = version;
     sha256 = "sha256-/e7PCA931t5j0dlvfZm04dQ7dvcCL/ek+BIe1zQj5p4=";
     };
     })
    ]
    ++
    ( with pkgs.vimExtraPlugins; [
      nvim-transparent
    ]);


  extraConfigLuaPre = ''
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
  '';

  };
}
