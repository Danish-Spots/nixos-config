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
    nvf.enable = true;
  };
  features.desktop = {
    wayland.enable = true;
    waybar.enable = true;
    hyprland.enable = true;
    walker.enable = false;
    swaync.enable = true;
    swww.enable = true;
    hyprlock.enable = true;
    hypridle.enable = true;
    hyprpolkitagent.enable = false;
    playerctld.enable = true;
    hyprshot.enable = true;
    gtk.enable = true;
    wofi = {
      enable = true;
      hyprlandIntegration.enable = true;
    };
  };
}
