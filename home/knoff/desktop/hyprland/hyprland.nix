{ config, inputs, lib, pkgs, ... }:
let
  inherit (config.colorscheme) colors;
  #jq = "${pkgs.jq}/bin/jq";
  fuzzel = "${pkgs.fuzzel}/bin/fuzzel";
  #grimblast = "${pkgs.}/bin/fuzzel";
  # mainmod = xyz TODO
in
{
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];

  imports = [
    inputs.hyprland.homeManagerModules.default
    {
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        # TODO move into a custom config file? or use writeto, and pass paths
        extraConfig = ''

          # Source a file (multi-file configs)
          # source = ~/.config/hypr/myColors.conf

          $mainMod = SUPER

          input {

            kb_layout = us
            kb_variant =
            kb_options = caps:menu # only applies after reboot?
            kb_model =
            kb_rules =

            follow_mouse = 1

            touchpad {
              natural_scroll = true
            }

            sensitivity = 0
          }

          general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 2
            gaps_out = 4
            border_size = 2
            col.active_border =  0xff${colors.base04}
            col.inactive_border = 0xff${colors.base02}

            col.nogroup_border_active = 0xff${colors.base2E}
            col.nogroup_border = 0x99${colors.base2E}

            layout = master
          }

          decoration {

            rounding = 10

            inactive_opacity=0.95

            drop_shadow = false
            shadow_range = 2
            shadow_render_power = 3
            col.shadow = 0xff${colors.base01}
            blur {
              enabled = true;
              passes = 1;
              size = 8;
              noise = 0.1
            }
          }


          animations {
            enabled = true

            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = myBezier, 0.00, 1, 0, 9
            bezier = instant, 0, 9, 0, 9
            bezier = popBezier, 0.34, 1.16, 0.64, 1
            bezier = slowStart, 0.32, 0, 0.67, 0

            animation = windows, 1, 3, default
            animation = windowsIn, 1, 2, default
            animation = windowsOut, 1, 1, instant # default, popin 80%
            animation = border, 1, 10, default
            #animation = borderangle, 1, 8, default
            animation = fade, 1, 10, default
            animation = workspaces, 1, 3, default
          }

          dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # you probably want this
          }

          master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = false
            new_on_top = true
            no_gaps_when_only = true
          }

          ## Master-Layout binds
          bind =, print, layoutmsg, swapwithmaster master
          bind =, XF86Fn, layoutmsg, addmaster

          gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true
          }

          group {
            insert_after_current = true;
            focus_removed_window = true;
            col.border_active = 0xff${colors.base0E}; # ff base0E
            col.border_inactive = 0x99${colors.base0E}; # 99 base0E
            col.border_locked_active =   0xff${colors.base20}; # red?
            col.border_locked_inactive = 0x99${colors.base20};

            groupbar {
              font_size = 10;
              gradients = false;
              render_titles = true;
              scrolling = false;
              text_color = 0xff${colors.base06};
              col.active = 0xff${colors.base0D}; # ff base0D
              col.inactive = 0x99${colors.base0D}; # 99 base0D
              col.locked_active = 0xff${colors.base20};
              col.locked_inactive = 0x99${colors.base20};
            }
          }

          misc {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              force_default_wallpaper = 0;
              enable_swallow = true; # TODO Config the regex
          }

          # Is this necessary?
          windowrule=float,^mako$
          windowrule=pin,^mako$

          # Example windowrule v1
          # windowrule = float, ^(kitty)$
          # Example windowrule v2
          # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
          # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more



          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = $mainMod, SPACE, exec, ${fuzzel} -b ${colors.base02}DD -t ${colors.base06}DD -m ${colors.base04}DD -C ${colors.base05}DD -s ${colors.base03}DD -S ${colors.base07}DD -M ${colors.base07}DD
          bind = $mainMod, C, killactive,
          bind = $mainMod, E, exit,
          bind = $mainMod, V, togglefloating,
          #bind = $mainMod, R, exec, wofi --show drun
          #bind = $mainMod, P, pseudo, # dwindle
          bind = $mainMod, S, togglesplit, # dwindle
          bind = $mainMod, F, fullscreen, 0
          #bind = $mainMod, T, tile,

          # Groups
          bind=$mainMod,g,togglegroup
          # bind=$mainMod,tab,changegroupactive, f
          bind=,page_down,changegroupactive,f
          bind=,page_up,changegroupactive, b

          bind=$mainMod, menu, submap, groups

          # caps_lock, gets bound to groups
          bind=ALT,menu,denywindowfromgroup, toggle
          bind=ALT,menu,lockactivegroup, toggle
          bind=,menu,focuscurrentorlast
          bind=$mainMod,tab,focuscurrentorlast


          # Resize windows splitratio, is far smoother.
          binde=$mainMod SHIFT,right, resizeactive,   4% 0
          binde=$mainMod SHIFT,left,  resizeactive,   -4% 0
          binde=$mainMod SHIFT,up,    resizeactive,   0 -4%
          binde=$mainMod SHIFT,down,  resizeactive,   0 4%

          # Monitor brightness
          binde=,XF86MonBrightnessUp,     exec,light -A 10
          binde=,XF86MonBrightnessDown,   exec,light -U 10

          # Volume
          binde=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          binde=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          binde=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

          # ~~~~~~~~~~~ SUBMAPS ~~~~~~~~~~~


          # ~~~~~~ resize


          # will switch to a submap called resize
          bind = $mainMod, R, submap, resize

          # will start a submap called "resize"
          submap=resize

          # sets repeatable binds for resizing the active window
          binde=,right,resizeactive,10 0
          binde=,left,resizeactive,-10 0
          binde=,up,resizeactive,0 -10
          binde=,down,resizeactive,0 10

          # use reset to go back to the global submap
          bind=,escape,submap,reset

          # will reset the submap, meaning end the current one and return to the global one
          submap=reset


          # ~~~~~~ Groups


          # will start a submap called "groups"
          submap=groups

          # disable current no group state?
          # sets repeatable binds for resizing the active window
          binde=,right, movewindoworgroup, r
          binde=,left, movewindoworgroup, l
          binde=,up, movewindoworgroup, u
          binde=,down, movewindoworgroup, d

          # Change this to be every key spelled out. like above

          binde=,right, submap, reset
          binde=,left, submap, reset
          binde=,up, submap, reset
          binde=,down, submap, reset

          # use reset to go back to the global submap
          bind=,escape,submap,reset # make this pass the esc. mod to the lower windows.

          # will reset the submap, meaning end the current one and return to the global one
          submap=reset


          # ~~~~~~~ Submap end ~~~~~~~~






          # ~~~~ Enviroment Variables ~~~~~
          # TODO! look at supplanting the env. with the nix config variables

          env = GDK_BACKEND,wayland,x11
          env = QT_QPA_PLATFORM,wayland;xcb
          env = SDL_VIDEODRIVER,wayland
          env = CLUTTER_BACKEND,wayland
          env = XDG_CURRENT_DESKTOP,Hyprland
          env = XDG_SESSION_TYPE,wayland
          env = XDG_SESSION_DESKTOP,Hyprland
          env = QT_AUTO_SCREEN_SCALE_FACTOR,1
          #env = GTK_THEME,Breeze-Dark
          #env = QT_STYLE_OVERRIDE,Breeze-Dark
          env = XCURSOR_THEME,Future-Cursors
          env = XCURSOR_SIZE,24
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
          #exec-once=gsettings set org.gnome.desktop.interface cursor-theme 'Future-cursors'
          #exec-once=hyprctl setcursor Future-cursors 24
          monitor=eDP-1,highres,auto,1.0


          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


          # Move Window with mainMod + ALT + arrow keys
          bind = $mainMod ALT, left, movewindow, l
          bind = $mainMod ALT, right, movewindow, r
          bind = $mainMod ALT, up, movewindow, u
          bind = $mainMod ALT, down, movewindow, d

          # TODO vim binds for movewindow

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          bind = $mainMod, A, movetoworkspace, special

          # Vim binds focus
          bind = $mainMod, h, movefocus, l
          bind = $mainMod, l, movefocus, r
          bind = $mainMod, k, movefocus, u
          bind = $mainMod, j, movefocus, d

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10


          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # Move/resize windows with mainMod + LMB/RMB and dragging
          #bindm = $mainMod, mouse:272, movewindow
          #bindm = $mainMod, mouse:273, resizewindow

          # Startup
          exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once=hyprpaper
          #exec-once=swayidle -w

        '';

      };
    }
  ];
}
