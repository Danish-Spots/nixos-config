{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {
    xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    wayland.windowManager.hyprland = {
      systemd.enable = false;
      enable = true;
      importantPrefixes = ["output" "source" "$" "bezier"];
      settings = {
        "$mainMod" = "SUPER";
        source = "/home/$USER/.cache/wal/colors-hyprland.conf";
        monitorv2 = {
          output = "";
          mode = "3840x2160@120";
          scale = 1.0;
        };

        animations = {
          enabled = true;
          bezier = [
            "fluid, 0.15, 0.85, 0.25, 1"
            "snappy, 0.3, 1, 0.4, 1"
          ];
          animation = [
            "windows, 1, 3, fluid, popin 5%"
            "windowsOut, 1, 2.5, snappy"
            "fade, 1, 4, snappy"
            "workspaces, 1, 1.7, fluid, slide"
            "specialWorkspace, 1, 4, fluid, slidefadevert -35%"
            "layers, 1, 2, snappy, popin 70%"
          ];
        };

        decoration = {
          blur = {
            enabled = true;
            passes = 5;
            size = 3;
            popups = true;
          };
          active_opacity = 0.9;
          inactive_opacity = 0.85;
          rounding = 16;
          shadow = {
            enabled = true;
            range = 12;
            render_power = 4;
            color = "rgba(0,0,0,.5)";
          };
        };

        dwindle = {
          preserve_split = true;
          pseudotile = true;
        };

        general = {
          border_size = 2;
          "col.active_border" = "$color9";
          "col.inactive_border" = "$color5";
          gaps_in = 5;
          gaps_out = 10;
          allow_tearing = true;
          layout = "dwindle";
        };

        input = {
          follow_mouse = 1;
          kb_layout = "us";
          kb_model = "";
          kb_rules = "";
          kb_variant = "";
          sensitivity = 0;
        };

        "misc:focus_on_activate" = true;

        bind = [
          "$mainMod, q, exec, kitty"
          "$mainMod, l, exec, hyprlock"
          "$mainMod, Space, exec, walker"
          "$mainMod, c, killactive"
          "$mainMod, M, exit"
          "$mainMod, P, pseudo"
          "$mainMod, F, fullscreen"
          "$mainMod, V, togglefloating"
          "$mainMod, J, togglesplit"
          "$mainMod, escape, exec, wlogout -b 2"
          # Cursor moving
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          #Window moving
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          ## Screenshotting
          "$mainMod SHIFT, S, exec, screenshot-area"
          ", Print, exec, screenshot-monitor"
          "$mainMod, Print, exec, screenshot-window"
          # Workspace related"
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
        ];

        bindm = [
          # Window resize
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        "debug:disable_logs" = true;
        # env=XCURSOR_SIZE,64
        # env = XCURSOR_THEME,Bibata-Modern-Ice
        # env=WLR_NO_HARDWARE_CURSORS,1
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "XCURSOR_THEME,Bibata-Modern-Ice"
        ];

        windowrule = [
          "float, title:Open File"
          "float, title:branchdialog"
          #polkit agent rules
          "pin,class:soteria"
          "center,class:soteria"
          "stayfocused,class:soteria"
          "opaque,class:soteria"
          "noscreenshare,class:soteria"
          "dimaround,class:soteria"
          "xray,class:soteria"
        ];

        layerrule = [
          # Layer rules
          "blur, waybar"
          "ignorezero, waybar"
          "ignorealpha 0.5, waybar"

          "blur, swaync-control-center"
          "blur, swaync-notification-window"
          "ignorezero, swaync-control-center"
          "ignorezero, swaync-notification-window"
          "ignorealpha 0.4, swaync-control-center"
          "ignorealpha 0.4, swaync-notification-window"

          "animation slide right, swaync-control-center"
          "animation slide right, swaync-notification-window"

          "noanim, selection"
        ];
      };
    };
  };
}
