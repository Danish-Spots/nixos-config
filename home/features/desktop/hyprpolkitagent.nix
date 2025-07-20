{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprpolkitagent;
in {
  options.features.desktop.hyprpolkitagent.enable = mkEnableOption "enable hypr polkit agent";

  config = mkIf cfg.enable {
    services.hyprpolkitagent.enable = true;
  };
}
