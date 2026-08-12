{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.playerctld;
in {
  options.features.desktop.playerctld.enable = mkEnableOption "enable playerctld";

  config = mkIf cfg.enable {
    services.playerctld.enable = true;
  };
}
