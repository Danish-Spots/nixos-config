{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.wofi;
  wallpaperDir = "${config.home.homeDirectory}/Wallpapers/Walls";
  wallpaperSwitchScript = pkgs.writeShellScriptBin "select-wallpaper" (
    builtins.replaceStrings
    ["@WALLPAPER_DIR@"]
    [wallpaperDir]
    (builtins.readFile ./wallpaper.sh)
  );
in {
  options.features.desktop.wofi.enable = mkEnableOption "Enable wofi and config";

  config = mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_WALLPAPERS_DIR = wallpaperDir;
      };
    };
    programs.wofi = {
      enable = true;
    };
    home.packages = [wallpaperSwitchScript];
  };
}
