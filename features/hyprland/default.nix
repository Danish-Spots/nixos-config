{ config, lib, ... }:

let
  cfg = config.features.hyprland;
in
{
  options.features.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland with default configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    
    home-manager.sharedModules = [
      ./home.nix
    ];
  };
}