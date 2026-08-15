{ ... }:

{
  imports = [
    ./gnome.nix
  ];

  features.gnome.enable = true;
  features.hyprland.enable = true;
}