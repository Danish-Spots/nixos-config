{pkgs, ...}: {
  imports = [./fish.nix ./pywal16.nix ./nvf.nix];

  home.packages = with pkgs; [
    coreutils
  ];
}
