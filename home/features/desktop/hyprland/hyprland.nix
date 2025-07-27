{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  imports = [
    ./soteria.nix
    ./hyprlock.nix
    ./hyprshot.nix
    ./swaync.nix
    ./waybar.nix
  ];
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

        bind =
          [
            "$mainMod, q, exec, kitty"
            "$mainMod, c, killactive"
            "$mainMod, M, exit"
            "$mainMod, P, pseudo"
            "$mainMod, F, fullscreen"
            "$mainMod, V, togglefloating"
            "$mainMod, J, togglesplit"
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
          ]
          # Workspace related"
          ++ (builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9));

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
        ];

        layerrule = [
          "noanim, selection"
        ];
      };
    };
  };
}
