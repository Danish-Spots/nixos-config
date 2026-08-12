{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.soteria.enable = mkEnableOption "Enable soteria integration in hyprland";

  config = mkIf cfg.soteria.enable {
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        #polkit agent rules
        "pin on, match:class gay.vaskel.soteria"
        "center on, match:class gay.vaskel.soteria"
        "stay_focused on, match:class gay.vaskel.soteria"
        "opaque on, match:class gay.vaskel.soteria"
        "no_screen_share on, match:class gay.vaskel.soteria"
        "dim_around on, match:class gay.vaskel.soteria"
        "xray on, match:class gay.vaskel.soteria"
      ];
    };
  };
}
