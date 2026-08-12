{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.hyprlock.enable = mkEnableOption "Enable hyprlock integration in hyprland";

  config = mkIf cfg.hyprlock.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "$mainMod, l, exec, hyprlock"
      ];
    };
  };
}
