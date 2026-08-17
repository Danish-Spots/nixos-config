{ pkgs, lib, ... }:

{
  imports = [
    ./quickshell
  ];

  home.packages = with pkgs; [
    kitty
    hyprpaper
  ];
  
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
  xdg.configFile."hypr/default-ux.lua".source = ./default-ux.lua;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;

  wayland.windowManager.hyprland = {
    enable = true;
  };
}