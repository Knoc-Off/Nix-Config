/*
Terminal emulator configuration
Alacritty configuration
Terminal window decorations and dimensions
Terminal plugins and keybindings
Terminal environment variables
Terminal mouse support
Terminal copy and paste behavior
Terminal startup behavior
*/
{ pkgs, config, nix-colors, ... }:
{

  home.packages = with pkgs; [
    wl-clipboard
  ];

    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "alacritty";
        window = {
          decorations = "full";
          title = "Terminal";
          dynamic_title = true;
          dimensions = {
            columns = 120;
            lines = 30;
          };
          padding = {
            x = 2;
            y = 2;
          };
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
        };
        cursor = {
          style = "Beam";
        };
        #mouse = {
          #double_click: { threshold: 300 }
          #triple_click: { threshold: 300 }
        #};
        window.opacity = 1;
        key_bindings = [
          {
            key = "F11";
            action = "ToggleFullscreen";
          }
          {
            key = "R";
            mods = "Alt";
            action = "ResetFontSize";

          }
          { 
            key = "V";
            mods = "Control|Shift";
            action = "Paste";
          }
          { 
            key = "V";
            mods = "Control";
            action = "Paste";
          }
          {
            key = "N";
            mods = "Alt";
            action = "SpawnNewInstance";
          }
          { 
            key = "Insert";
            mods = "Shift";
            action = "PasteSelection";
          }
        ];
        font = {
          normal = {
            family = "Hack";
            style = "regular";
          };
          bold = {
            family = "Hack";
            style = "regular";
          };
          italic = {
            family = "Hack";
            style = "regular";
          };
          bold_italic = {
            family = "Hack";
            style = "regular";
          };
          size = 15.00;
        };
        colors = {
          primary = {
            background = "#${config.colorScheme.colors.base02}";
            foreground = "#${config.colorScheme.colors.base06}"; # "#c5c8c6";
            dim_foreground = "#${config.colorScheme.colors.base05}";
            bright_foreground = "#${config.colorScheme.colors.base06}";
          };
          cursor = { 
            text = "#${config.colorScheme.colors.base02}"; # CellBackground";
            cursor = "#${config.colorScheme.colors.base06}"; #CellForeground";
          };
          vi_mode_cursor = {
            text = "#${config.colorScheme.colors.base06}";
            cursor = "#${config.colorScheme.colors.base05}";
          };
          search = {
            matches = {
              foreground = "CellForeground";
              background = "#${config.colorScheme.colors.base03}";
            };
            focused_match = {
              foreground = "CellForeground";
              background = "#${config.colorScheme.colors.base03}";
            };
          };
          selection = {
            text = "CellForeground";
            background = "#${config.colorScheme.colors.base04}";
          };
        };
      };
    };
  }
