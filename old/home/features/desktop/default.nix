{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./waybar/waybar.nix
    ./hyprland/hyprland.nix
    ./walker/walker.nix
    ./swaync/swaync.nix
    ./swww.nix
    ./hyprlock/hyprlock.nix
    ./hypridle.nix
    ./hyprpolkitagent.nix
    ./playerctld.nix
    ./hyprshot/hyprshot.nix
    ./gtk.nix
    ./wofi/wofi.nix
    ./wlogout/wlogout.nix
  ];

  home.packages = with pkgs; [
  ];
}
