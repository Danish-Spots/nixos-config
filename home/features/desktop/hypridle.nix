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
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
