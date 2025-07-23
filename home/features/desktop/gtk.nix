{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.gtk;
in {
  options.features.desktop.gtk.enable = mkEnableOption "Enable gtk themes";

  config = mkIf cfg.enable {
    # home.sessionVariables = {
    #   GTK_THEME = "Nordic";
    # };
    gtk = {
      enable = true;
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      theme = mkForce {
        name = "Nordic";
        package = pkgs.nordic;
      };
    };
  };
}
