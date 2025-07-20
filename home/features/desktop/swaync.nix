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
      # settings = {

      # };

      # Uncomment below to style swaync
      # style = ''

      # '';
    };
  };
}
