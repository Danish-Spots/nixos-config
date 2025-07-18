{pkgs, ...}: {

  imports = [./fish.nix];

  home.packages = with pkgs; [
    coreutils
  ];
}