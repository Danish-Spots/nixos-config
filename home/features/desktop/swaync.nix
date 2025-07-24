{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.swaync;
in {
  options.features.desktop.swaync.enable = mkEnableOption "enable swaync and its config";

  config = mkIf cfg.enable {
    services.swaync = {
      enable = true;
      # Uncomment below to configure swaync
      settings = {
        ignore-gtk-theme = true;
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        control-center-exclusive-zone = false;
        layer-shell = true;
        notification-2fa-action = true;
        notification-inline-replies = true;
        notification-window-width = 500;
        notification-icon-size = 60;
        # notification-body-image-height = 180;
        # notification-body-image-width = 180;

        timeout = 12;
        timeout-low = 6;
        timeout-critical = 0;
        fit-to-screen = true;
        cssPriority = "user";
        relative-timestamps = true;
        transition-time = 200;
        hide-on-clear = false;
        hide-on-action = true;
        script-fail-notify = true;
        image-visibility = "when-available";
        widgets = [
          "title"
          "mpris"
          "volume"
          "buttons-grid"
          "notifications"
        ];
        widget-config = {
          title = {
            text = "Notification center";
            clear-all-button = true;
            button-text = "󰩹";
          };
          mpris = {
            blacklist = ["playerctld"];
          };
          volume = {
            label = "󰕾";
          };

          buttons-grid = {
            actions = [
              {
                "label" = "󰝟";
                "command" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                "type" = "toggle";
              }
              {
                "label" = "󰍭";
                "command" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
                "type" = "toggle";
              }
              {
                "label" = "󰤄";
                "command" = "swaync-client -d";
                "type" = "toggle";
              }
              {
                "label" = "󰌾";
                "command" = "hyprlock";
              }
              {
                "label" = "󰦛";
                "command" = "reboot";
              }
              {
                "label" = "󰐥";
                "command" = "shutdown now";
              }
            ];
          };
        };
      };

      # Uncomment below to style swaync
      # style = ''

      # '';
    };
  };
}
