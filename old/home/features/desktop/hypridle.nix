{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hypridle;
in {
  options.features.desktop.hypridle.enable = mkEnableOption "enable hypridle and config";

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      importantPrefixes = ["$"];
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            # After 10 mminutes
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
