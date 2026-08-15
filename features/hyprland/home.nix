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
      "$mod" = "SUPER";

      bind = [
        "$mod, q, exec, kitty"
        "$mod, c, killactive"
        "$mod, m, exit"
      ];
    };
  };
}