{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprshot;
  screenshotDir = "${config.home.homeDirectory}/Pictures/Screenshots";
  makePatchedScript = {
    script,
    saveDir,
    name,
  }: let
    content =
      builtins.replaceStrings
      ["@SCREENSHOT_DIR@"]
      [saveDir]
      (builtins.readFile script);
  in
    pkgs.writeShellScriptBin name content;
  scripts = [
    ./screenshot-area.sh
    ./screenshot-monitor.sh
    ./screenshot-window.sh
  ];

  patchedScripts = map (script: let
    scriptName = builtins.baseNameOf script;
    binName = removeSuffix ".sh" scriptName;
  in
    makePatchedScript {
      script = script;
      name = binName;
      saveDir = screenshotDir;
    })
  scripts;
in {
  options.features.desktop.hyprshot.enable = mkEnableOption "Enable hyprshot screenshotting";
  config = mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      pictures = "${config.home.homeDirectory}/Pictures";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = screenshotDir;
      };
    };
    home = {
      sessionVariables = {
        SCREENSHOTS_DIR = screenshotDir;
      };
      packages = with pkgs;
        [
          hyprshot
          hyprpicker
        ]
        ++ patchedScripts;
    };
  };
}
