{config, ...}: {
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/desktop
  ];

  features.cli.fish.enable = true;
  features.desktop.wayland.enable = true;
  features.desktop.waybar.enable = true;
  features.desktop.hyprland.enable = true;
  features.desktop.walker.enable = true;
  features.desktop.swaync.enable = true;
  features.desktop.swww.enable = true;
  features.desktop.hyprlock.enable = true;
  features.desktop.hypridle.enable = true;
}
