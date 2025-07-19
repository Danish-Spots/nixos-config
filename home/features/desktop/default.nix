{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./waybar.nix
    ./hyprland.nix
    ./walker.nix
  ];

  home.packages = with pkgs; [
  ];
}
