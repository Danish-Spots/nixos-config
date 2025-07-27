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
        "pin,class:gay.vaskel.soteria"
        "center,class:gay.vaskel.soteria"
        "stayfocused,class:gay.vaskel.soteria"
        "opaque,class:gay.vaskel.soteria"
        "noscreenshare,class:gay.vaskel.soteria"
        "dimaround,class:gay.vaskel.soteria"
        "xray,class:gay.vaskel.soteria"
      ];
    };
  };
}
