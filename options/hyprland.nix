{ ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home-manager.users.helehex = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;

      settings = {
        ################
        ### MONITORS ###
        ################

        # See https://wiki.hypr.land/Configuring/Monitors/
        monitor = [
          "DP-1, 2560x1440@144, auto-center-right, 1"
          "HDMI-A-1, preferred, auto-center-left, 1"
          ",preferred,auto,auto"
        ];

        ###################
        ### MY PROGRAMS ###
        ###################

        # See https://wiki.hypr.land/Configuring/Keywords/

        # Set programs that you use
        "$terminal" = "alacritty";
        "$fileManager" = "thunar";
        "$menu" = "rofi -show drun";

        #################
        ### AUTOSTART ###
        #################

        # Autostart necessary processes (like notifications daemons, status bars, etc.)
        # Or execute your favorite apps at launch like this:
        exec-once = [
          "hyprpaper"
        ];

        #############################
        ### ENVIRONMENT VARIABLES ###
        #############################

        # See https://wiki.hypr.land/Configuring/Environment-variables/

        # env = XCURSOR_SIZE,24
        # env = HYPRCURSOR_SIZE,24

        ###################
        ### PERMISSIONS ###
        ###################

        # See https://wiki.hypr.land/Configuring/Permissions/
        # Please note permission changes here require a Hyprland restart and are not applied on-the-fly
        # for security reasons

        # ecosystem {
        #   enforce_permissions = 1
        # }

        # permission = /usr/(bin|local/bin)/grim, screencopy, allow
        # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
        # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow

        #####################
        ### LOOK AND FEEL ###
        #####################

        # Refer to https://wiki.hypr.land/Configuring/Variables/

        # https://wiki.hypr.land/Configuring/Variables/#general
        general = {
          border_size = 2;
          gaps_in = 4;
          gaps_out = 8;

          # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
          # col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          # col.inactive_border = "rgba(595959aa)";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;
          # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
          allow_tearing = false;
          layout = "dwindle";
        };

        # https://wiki.hypr.land/Configuring/Variables/#decoration
        decoration = {
          rounding = 8;
          rounding_power = 2;
          # Change transparency of focused and unfocused windows
          active_opacity = 0.9;
          inactive_opacity = 0.9;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            # color = "rgba(1a1a1aee)";
          };

          # https://wiki.hypr.land/Configuring/Variables/#blur
          blur = {
            enabled = true;
            size = 4;
            passes = 1;
            vibrancy = 0.1;
          };
        };

        # https://wiki.hypr.land/Configuring/Variables/#animations
        animations = {
          enabled = "yes";

          # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
          #        NAME,           X0,   Y0,   X1,   Y1
          bezier = [
            "easeOutQuint,0.25,1,0.3,1"
            "easeInOutCubic,0.75,0.1,0.4,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          # Default animations, see https://wiki.hypr.land/Configuring/Animations/
          #           NAME,          ONOFF, SPEED, CURVE,        [STYLE]
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.4, easeOutQuint"
            "windows, 1, 4.8, easeOutQuint"
            "windowsIn, 1, 4, easeOutQuint, popin 80%"
            "windowsOut, 1, 4, linear, popin 80%"
            "fadeIn, 1, 1.75, almostLinear"
            "fadeOut, 1, 1.5, almostLinear"
            "fade, 1, 3, quick"
            "layers, 1, 3.75, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.8, almostLinear"
            "fadeLayersOut, 1, 1.4, almostLinear"
            "workspaces, 1, 2, almostLinear, fade"
            "workspacesIn, 1, 1.2, almostLinear, fade"
            "workspacesOut, 1, 2, almostLinear, fade"
            "zoomFactor, 1, 7, quick"
          ];
        };

        # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
        # "Smart gaps" / "No gaps when only"
        # uncomment all if you wish to use that.
        # workspace = w[tv1], gapsout:0, gapsin:0
        # workspace = f[1], gapsout:0, gapsin:0
        # windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
        # windowrule = rounding 0, floating:0, onworkspace:w[tv1]
        # windowrule = bordersize 0, floating:0, onworkspace:f[1]
        # windowrule = rounding 0, floating:0, onworkspace:f[1]

        # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        # https://wiki.hypr.land/Configuring/Variables/#misc
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        #############
        ### INPUT ###
        #############

        # https://wiki.hypr.land/Configuring/Variables/#input
        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 2;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          # touchpad = {
          #   natural_scroll = false;
          # };
        };

        # See https://wiki.hypr.land/Configuring/Gestures
        gesture = "3, horizontal, workspace";

        # Example per-device config
        # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
        # device = {
        #   name = "epic-mouse-v1";
        #   sensitivity = -0.5;
        # };

        ###################
        ### KEYBINDINGS ###
        ###################

        # See https://wiki.hypr.land/Configuring/Keywords/
        "$mainMod" = "SUPER";

        # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
        bind = [
          "$mainMod, C, exec, $terminal"
          "$mainMod, X, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, F, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, space, exec, $menu"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          # "$mainMod, S, togglespecialworkspace, magic"
          # "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

          # Requires playerctl
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        ##############################
        ### WINDOWS AND WORKSPACES ###
        ##############################

        # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
        # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

        # Example windowrule
        # windowrule = float,class:^(kitty)$,title:^(kitty)$

        windowrule = [
          # Ignore maximize requests from apps. You'll probably like this.
          "suppressevent maximize, class:.*"

          # Fix some dragging issues with XWayland
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };
    };
  };
}
