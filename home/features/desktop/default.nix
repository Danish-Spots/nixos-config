{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./waybar/waybar.nix
    ./hyprland.nix
    ./walker/walker.nix
    ./swaync.nix
    ./swww.nix
    ./hyprlock/hyprlock.nix
    ./hypridle.nix
    ./hyprpolkitagent.nix
    ./playerctld.nix
    ./hyprshot/hyprshot.nix
    ./gtk.nix
  ];

  home.packages = with pkgs; [
  ];
}
