{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.thunar;
in {
  options.features.thunar.enable = mkEnableOption "Enable thunar and config";

  config = mkIf cfg.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
    };
    programs.xfconf.enable = true;
    programs.dconf.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.tumbler.enable = true;
    environment.systemPackages = [pkgs.xdg-utils];
  };
}
