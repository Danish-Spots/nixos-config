{ pkgs, lib, ... }:

{
  imports = [
    ./quickshell
  ];

  home.packages = with pkgs; [
    kitty
  ];
  
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;

  wayland.windowManager.hyprland = {
    enable = true;
  };
}