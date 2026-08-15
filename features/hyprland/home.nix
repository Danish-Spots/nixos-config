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
      
      exec-once = [
        "quickshell"
      ];

      bind = [
        "$mod, q, exec, kitty"
        "$mod, c, killactive"
        "$mod, m, exit"
        "$mod, SPACE, exec, qs ipc call launcher toggle"
      ];
    };
  };
}