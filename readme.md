# NixOS Configuration

This is my NixOS configuration and includes alot of packages and configurations.
Anywhere there is a configuration for a package, I tried to do that with Nix, so that I can keep the config tied to my flake.

Packages 
- hyprland
- hyprshot
- hypridle
- hyprlock
- waybar
- swaync
- soteria
- swww
- playerctld
- wofi
- steam
- thunar
- git 
- neovim through nvf
- vscode
- wlogout

and some others

I did this as more of a project than anything else, but after using it for a week while making this configuration.
It has grown on me to the point that I just want to use it.

## Commands
#### Rebuild nixos with the flake
- sudo nixos-rebuild switch --flake .#nixos

#### Check flake configurations
- nix flake check --show-trace
