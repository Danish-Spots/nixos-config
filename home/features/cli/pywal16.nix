{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.pywal16;
in {
  options.features.cli.pywal16.enable = mkEnableOption "Enable pywal16";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pywal16
    ];
  };
}
