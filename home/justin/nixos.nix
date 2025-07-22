{config, ...}: {
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/desktop
  ];

  features.cli = {
    fish.enable = true;
    pywal16.enable = true;
  };
  features.desktop = {
    wayland.enable = true;
    waybar.enable = true;
    hyprland.enable = true;
    walker.enable = true;
    swaync.enable = true;
    swww.enable = true;
    hyprlock.enable = true;
    hypridle.enable = true;
    hyprpolkitagent.enable = true;
    playerctld.enable = true;
  };
}
