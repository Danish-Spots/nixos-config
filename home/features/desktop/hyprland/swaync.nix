{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.swaync.enable = mkEnableOption "Enable swaync integration in hyprland";

  config = mkIf cfg.swaync.enable {
    wayland.windowManager.hyprland.settings = {
      layerrule = [
        # Layer rules
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.4, swaync-control-center"
        "ignorealpha 0.4, swaync-notification-window"

        "animation slide right, swaync-control-center"
        "animation slide right, swaync-notification-window"
      ];
    };
  };
}
