{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./waybar.nix
    ./hyprland.nix
    ./walker/walker.nix
    ./swaync.nix
    ./swww.nix
    ./hyprlock/hyprlock.nix
    ./hypridle.nix
    ./hyprpolkitagent.nix
  ];

  home.packages = with pkgs; [
  ];
}
