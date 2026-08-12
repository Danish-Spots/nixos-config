{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprlock;
  userCap = pkgs.writeShellScriptBin "user-caps" (builtins.readFile ./user.sh);
  player = pkgs.writeShellScriptBin "lock-player" (builtins.readFile ./player.sh);
in {
  options.features.desktop.hyprlock.enable = mkEnableOption "Enable hyprlock and config";

  config = mkIf cfg.enable {
    home.packages = [userCap player pkgs.bc];
    programs.hyprlock = {
      enable = true;
      importantPrefixes = ["source" "$" "bezier" "monitor" "size"];
      sourceFirst = true;
      extraConfig = ''

      '';
      settings = {
        source = "/home/$USER/.cache/wal/colors-hyprland.conf";
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "$wallpaper";
            blur_passes = 3;
            blur_size = 5;
            brightness = 0.6;
          }
        ];
        input-field = [
          {
            monitor = "";
            size = "6%, 4%";
            outline_thickness = 2;
            dots_rounding = 4;
            dots_spacing = .5;
            dots_center = true;

            inner_color = "$backgroundCol";
            outer_color = "$backgroundCol $backgroundCol";
            check_color = "$backgroundCol $backgroundCol";
            fail_color = "$backgroundCol $backgroundCol";
            font_color = "$color9";
            font_family = "CodeNewRoman Nerd Font Propo";
            fade_on_empty = false;
            shadow_color = "rgba(0,0,0,0.5)";
            shadow_passes = 2;
            shadow_size = 2;
            rounding = 20;
            placeholder_text = ''<i></i>'';
            position = "0, -200";
            halign = "center";
            valign = "center";
          }
        ];
        image = [
          {
            monitor = "";
            path = "$wallpaper";
            position = "0,0";
            halign = "center";
            valign = "center";
            rounding = "200";
          }
          {
            monitor = "";
            path = "";
            size = 250;
            rounding = 5;
            border_size = 0;
            rotate = 0;
            reload_time = 2;
            reload_cmd = "lock-player --arturl";
            position = "-50%, -800";
            halign = "right";
            valign = "center";
            opacity = 0.5;
          }
        ];

        label = [
          {
            text = "$TIME";
            monitor = "";
            color = "$color15";
            font_size = 200;
            font_family = "CodeNewRoman Nerd Font Propo";
            shadow = 0;
            position = "0,400";
            valign = "center";
            halign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo $(LC_TIME=en_US.UTF-8 date +"%A, %B %d")'';
            color = "$color14";
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "0,200";
            font_size = 100;
            valign = "center";
            halign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] user-caps'';
            color = "$color15";
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "0,0";
            font_size = 50;
            valign = "center";
            halign = "center";
          }
          # Title
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(lock-player --title)\"";
            color = "rgba(255, 255, 255, 0.8)";
            font_size = 24;
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "51%, -705";
            halign = "left";
            valign = "center";
          }
          # Album
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(lock-player --album)\"";
            color = "rgba(255, 255, 255, 1)";
            font_size = 20;
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "51%, -750";
            halign = "left";
            valign = "center";
          }
          # Artist
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(lock-player --artist)\"";
            color = "rgba(255, 255, 255, 0.8)";
            font_size = 20;
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "51%, -785";
            halign = "left";
            valign = "center";
          }
          # Length
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(lock-player --length) \"";
            color = "rgba(255, 255, 255, 1)";
            font_size = 18;
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "51%, -850";
            halign = "left";
            valign = "center";
          }
          # Source with icon
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(lock-player --source)\"";
            color = "rgba(255, 255, 255, 0.6)";
            font_size = 14;
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "51%, -875";
            halign = "left";
            valign = "center";
          } # Status icon
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(lock-player --status)\"";
            color = "rgba(255, 255, 255, 1)";
            font_size = 14;
            font_family = "CodeNewRoman Nerd Font Propo";
            position = "51%, -905";
            halign = "left";
            valign = "center";
          }
        ];
      };
    };
  };
}
