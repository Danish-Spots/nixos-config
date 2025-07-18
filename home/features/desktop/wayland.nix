{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let  cfg = config.features.desktop.wayland;
in {
  options.features.desktop.wayland.enable = mkEnableOption "enable extra tooling for wayland";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      hyprlock
      qt6.qtwayland
      slurp
      wlogout
    ];
  };
}