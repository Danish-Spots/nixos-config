{ pkgs, ... }:

{
  imports = [
    ./quickshell
  ];

  home.packages = with pkgs; [
    kitty
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # Config here
    };
  };
}