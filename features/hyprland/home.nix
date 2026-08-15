{ pkgs, lib, ... }:

{
  imports = [
    ./quickshell
  ];

  home.packages = with pkgs; [
    kitty
  ];
  
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
  xdg.configFile."hypr/default-ux.lua".source = ./default-ux.lua;

  wayland.windowManager.hyprland = {
    enable = true;
  };
}