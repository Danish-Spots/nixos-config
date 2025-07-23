{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.grim;
  screenshotWindow = pkgs.writeShellScriptBin "screenshot-window" (builtins.readFile ./screenshot-window.sh);
  screenshotMonitor = pkgs.writeShellScriptBin "screenshot-monitor" (builtins.readFile ./screenshot-monitor.sh);
  screenshotArea = pkgs.writeShellScriptBin "screenshot-area" (builtins.readFile ./screenshot-area.sh);
in {
  options.features.desktop.grim.enable = mkEnableOption "Enable grim screenshotting";
  config = mkIf cfg.enable {
    home = {
      file = {
        "Pictures/Screenshots".directory = {
          recursive = true;
        };
      };
      packages = with pkgs; [
        grim
        slurp
        screenshotArea
        screenshotMonitor
        screenshotWindow
      ];
    };
  };
}
