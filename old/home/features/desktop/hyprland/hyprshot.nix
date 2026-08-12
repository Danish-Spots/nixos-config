{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.hyprshot.enable = mkEnableOption "Enable hyprshot integration in hyprland";

  config = mkIf cfg.hyprshot.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        ## Screenshotting
        "$mainMod SHIFT, S, exec, screenshot-area"
        ", Print, exec, screenshot-monitor"
        "$mainMod, Print, exec, screenshot-window"
      ];
    };
  };
}
