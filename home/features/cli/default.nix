{pkgs, ...}: {
  imports = [./fish.nix ./pywal16.nix];

  home.packages = with pkgs; [
    coreutils
  ];
}
