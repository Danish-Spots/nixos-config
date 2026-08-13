{ config, lib, ... }:

let
  cfg = config.features.gnome;
in
{
  options.features.gnome = {
    enable = lib.mkEnableOption "GNOME desktop environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}