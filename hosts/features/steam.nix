{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.steam;
in {
  options.features.steam.enable = mkEnableOption "Enable steam and config";

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
