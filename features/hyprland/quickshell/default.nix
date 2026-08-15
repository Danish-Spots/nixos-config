{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
  ];

  xdg.configFile."quickshell" = {
    source = ./qml;
    recursive = true;
  };
}