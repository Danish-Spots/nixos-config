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
    wayland.windowManager.hyprland = {
      systemd.enable = false;
      enable = true;
      # settings = {
      #   source = "/home/$USER/.cache/wal/colors-hyprland.conf";
      #   monitor = ",3840x2160@120,auto,auto";
      #   exec-once = [
      #     # "walker --gapplication-service"
      #   ];

      #   env = [
      #     "XCURSOR_SIZE,32"
      #     "WLR_NO_HARDWARE_CURSORS,1"
      #     # "GTK_THEME,Dracula"
      #     "LIBVA_DRIVER_NAME,nvidia"
      #     "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      #   ];

      #   input = {
      #     kb_layout = "us";
      #     kb_variant = "";
      #     kb_model = "";
      #     kb_rules = "";
      #     kb_options = "";
      #     follow_mouse = 1;
      #     sensitivity = 0;
      #   };

      #   general = {
      #     gaps_in = 5;
      #     gaps_out = 10;
      #     allow_tearing = true;
      #     border_size = 2;
      #     "col.active_border" = "$color9";
      #     "col.inactive_border" = "$color5";
      #     layout = "dwindle";
      #   };

      #   decoration = {
      #     rounding = 16;
      #     blur = {
      #       enabled = true;
      #       size = 3;
      #       passes = 5;
      #       popups = true;
      #     };
      #     active_opacity = 0.9;
      #     inactive_opacity = 0.85;
      #     shadow = {
      #       enabled = true;
      #       range = 12;
      #       render_power = 4;
      #       color = "rgba(0,0,0,.5)";
      #     };
      #   };

      #   animations = {
      #     enabled = true;
      #     bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      #     animation = [
      #       "windows, 1, 3, fluid, popin 5%"
      #       "windowsOut, 1, 2.5, snappy"
      #       "fade, 1, 4, snappy"
      #       "workspaces, 1, 1.7, fluid, slide"
      #       "specialWorkspace, 1, 4, fluid, slidefadevert -35%"
      #       "layers, 1, 2, snappy, popin 70%"
      #     ];
      #   };

      #   dwindle = {
      #     pseudotile = true;
      #     preserve_split = true;
      #   };
      #   misc = {
      #     focus_on_activate = true;
      #   };
      #   xwayland = {
      #     force_zero_scaling = true;
      #   };
      #   windowrule = [
      #     # "float, file_progress"
      #     # "float, confirm"
      #     # "float, dialog"
      #     # "float, download"
      #     # "float, notification"
      #     # "float, error"
      #     # "float, splash"
      #     # "float, confirmreset"
      #     "float, title:Open File"
      #     "float, title:branchdialog"
      #     # "float, Lxappearance"
      #     # "float, Wofi"
      #     # "float, dunst"
      #     # "animation none,Wofi"
      #     # "float,viewnior"
      #     # "float,feh"
      #     # "float, pavucontrol-qt"
      #     # "float, pavucontrol"
      #     # "float, file-roller"
      #     # "fullscreen, wlogout"
      #     # "float, title:wlogout"
      #     # "fullscreen, title:wlogout"
      #     # "idleinhibit focus, mpv"
      #     # "idleinhibit fullscreen, firefox"
      #     "float, title:^(Media viewer)$"
      #     "float, title:^(Volume Control)$"
      #     "float, title:^(Picture-in-Picture)$"
      #     "size 800 600, title:^(Volume Control)$"
      #     "move 75 44%, title:^(Volume Control)$"
      #   ];

      #   "$mainMod" = "SUPER";

      #   bind = [
      #     # "$mainMod, return, exec, kitty -e zellij-ps"
      #     "$mainMod, q, exec, kitty"
      #     # "$mainMod SHIFT, e, exec, kitty -e zellij_nvim"
      #     # "$mainMod, o, exec, thunar"
      #     "$mainMod, l, exec, uwsm app -- wlogout -p layer-shell"
      #     "$mainMod, Space, exec, walker"
      #     "$mainMod, c, killactive"
      #     "$mainMod, M, exit"
      #     "$mainMod, F, fullscreen"
      #     "$mainMod, V, togglefloating"
      #     # "$mainMod, D, exec, wofi --show drun --allow-images"
      #     # "$mainMod SHIFT, S, exec, bemoji"
      #     # "$mainMod, P, exec, wofi-pass"
      #     # "$mainMod SHIFT, P, pseudo"
      #     "$mainMod, J, togglesplit"
      #     "$mainMod, left, movefocus, l"
      #     "$mainMod, right, movefocus, r"
      #     "$mainMod, up, movefocus, u"
      #     "$mainMod, down, movefocus, d"
      #     "$mainMod, 1, workspace, 1"
      #     "$mainMod, 2, workspace, 2"
      #     "$mainMod, 3, workspace, 3"
      #     "$mainMod, 4, workspace, 4"
      #     "$mainMod, 5, workspace, 5"
      #     "$mainMod, 6, workspace, 6"
      #     "$mainMod, 7, workspace, 7"
      #     "$mainMod, 8, workspace, 8"
      #     "$mainMod, 9, workspace, 9"
      #     "$mainMod, 0, workspace, 10"
      #     "$mainMod SHIFT, 1, movetoworkspace, 1"
      #     "$mainMod SHIFT, 2, movetoworkspace, 2"
      #     "$mainMod SHIFT, 3, movetoworkspace, 3"
      #     "$mainMod SHIFT, 4, movetoworkspace, 4"
      #     "$mainMod SHIFT, 5, movetoworkspace, 5"
      #     "$mainMod SHIFT, 6, movetoworkspace, 6"
      #     "$mainMod SHIFT, 7, movetoworkspace, 7"
      #     "$mainMod SHIFT, 8, movetoworkspace, 8"
      #     "$mainMod SHIFT, 9, movetoworkspace, 9"
      #     "$mainMod SHIFT, 0, movetoworkspace, 10"
      #     # "$mainMod, mouse_down, workspace, e+1"
      #     # "$mainMod, mouse_up, workspace, e-1"
      #   ];

      #   bindm = [
      #     "$mainMod, mouse:272, movewindow"
      #     "$mainMod, mouse:273, resizewindow"
      #   ];

      #   windowrulev2 = [
      #     # "workspace 1,class:(Emacs)"
      #     # "workspace 3,opacity 1.0, class:(brave-browser)"
      #     # "workspace 4,class:(com.obsproject.Studio)"
      #   ];

      #   "debug:disable_logs" = true;
      # };
    };
  };
}
