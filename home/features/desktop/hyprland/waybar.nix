{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.waybar.enable = mkEnableOption "Enable waybar integration in hyprland";

  config = mkIf cfg.waybar.enable {
    wayland.windowManager.hyprland.settings = {
      layerrule = [
        # Layer rules
        "blur, waybar"
        "ignorezero, waybar"
        "ignorealpha 0.5, waybar"
      ];
    };
  };
}
