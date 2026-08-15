{ ... }:

{
  imports = [
    ./gnome.nix
    ./hyprland
  ];

  features.gnome.enable = true;
  features.hyprland.enable = true;
}