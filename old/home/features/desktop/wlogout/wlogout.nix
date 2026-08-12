{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.wlogout;
in {
  options.features.desktop.wlogout.enable = mkEnableOption "Enable logout and config";
  options.features.desktop.wlogout.hyprlandIntegration.enable = mkEnableOption "Enable hyprland integration";

  config = mkIf cfg.enable {
    xdg = {
      configFile = builtins.listToAttrs (map (file: {
        name = "wlogout/${file}";
        value.source = ./${file};
      }) ["lock.png" "logout.png" "power.png" "restart.png" "style.css"]);
    };
    wayland.windowManager.hyprland.settings = mkIf cfg.hyprlandIntegration.enable {
      bind = [
        "$mainMod, escape, exec, pidof wlogout || wlogout -b 2"
      ];
    };
    programs.wlogout = {
      enable = true;
      layout = [
        {
          action = "loginctl lock-session";
          label = "lock";
          text = "Lock";
        }
        {
          action = "systemctl reboot || loginctl reboot";
          label = "reboot";
          text = "Reboot";
        }
        {
          action = "loginctl terminate-user $USER";
          label = "logout";
          text = "Logout";
        }
        {
          action = "systemctl poweroff || loginctl poweroff";
          label = "shutdown";
          text = "Shutdown";
        }
      ];
    };
  };
}
