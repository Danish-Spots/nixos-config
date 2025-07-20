{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.swww;
in {
  options.features.desktop.swww.enable = mkEnableOption "enable swww";

  config = mkIf cfg.enable {
    services.swww.enable = true;
  };
}
