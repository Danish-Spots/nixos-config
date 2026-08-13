{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./firefox.nix
  ];

  home.packages = with pkgs; [
    git
    fastfetch
    ghostty
  ];
}