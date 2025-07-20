{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.desktop.walker;
in {
  imports = [inputs.walker.homeManagerModules.default];
  options.features.desktop.walker.enable = mkEnableOption "enable walker and config";

  config = mkIf cfg.enable {
    programs.walker = {
      enable = true;
      runAsService = true;

      config = importTOML ./walker.toml;
    };
  };
}
