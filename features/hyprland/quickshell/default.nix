{ pkgs, ... }:

{
  home.packages = with pkgs; [
    quickshell
    qt6.qtdeclarative
  ];

  xdg.configFile."quickshell" = {
    source = ./qml;
    recursive = true;
  };
}