{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.wofi;
  wallpaperDir = "${config.home.homeDirectory}/Wallpapers/Walls";
  wallpaperSwitchScript = pkgs.writeShellApplication {
    name = "select-wallpaper";
    runtimeInputs = [
      pkgs.swww
      pkgs.pywal16
      pkgs.wofi
      pkgs.imagemagick
    ];
    text =
      builtins.replaceStrings
      ["@WALLPAPER_DIR@"]
      [wallpaperDir]
      (builtins.readFile ./wallpaper.sh);
  };
  launchApp = pkgs.writeShellScriptBin "launch-app" (builtins.readFile ./app-launcher.sh);
in {
  options.features.desktop.wofi.enable = mkEnableOption "Enable wofi and config";
  options.features.desktop.wofi.hyprlandIntegration.enable = mkEnableOption "Enable wofi keybinds in hyprland";

  config = mkIf cfg.enable {
    xdg = {
      configFile = builtins.listToAttrs (map (file: {
        name = "wofi/${file}";
        value.source = ./${file};
      }) ["wallpaper" "style.css" "style-wallpaper.css"]);
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_WALLPAPERS_DIR = wallpaperDir;
        };
      };
    };
    wayland.windowManager.hyprland.settings = mkIf cfg.hyprlandIntegration.enable {
      bind = [
        "$mainMod, Space, exec, launch-app"
        "$mainMod SHIFT, Space, exec, select-wallpaper"
      ];
    };
    programs.wofi = {
      enable = true;
      settings = {
        allow_images = true;
        width = 500;
        show = "drun";
        prompt = "Search";
        height = "400";
        term = "kitty";
        hide_scroll = true;
        print_command = true;
        insensitive = true;
        columns = 1;
        no_actions = true;
        normal_window = true;
      };
    };
    home.packages = [wallpaperSwitchScript launchApp];
  };
}
