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
        "blur on, match:namespace swaync-control-center"
        "blur on, match:namespace swaync-notification-window"
        "ignore_alpha 0.4, match:namespace swaync-control-center"
        "ignore_alpha 0.4, match:namespace swaync-notification-window"

        "animation slide right, match:namespace swaync-control-center"
        "animation slide right, match:namespace swaync-notification-window"
      ];
    };
  };
}
