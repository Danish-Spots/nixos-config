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

I drew alot of inspiration from various projects. Some examples are 
- https://code.m3ta.dev/m3tam3re/nixcfg
- https://github.com/elifouts/Dotfiles/tree/main 

This guy's playlist I watched until ep 5, as I didn't feel like I needed more. But it was a good learning playlist (the fist link is the repository he shares).
- https://www.youtube.com/watch?v=43VvFgPsPtY&list=PLCQqUlIAw2cCuc3gRV9jIBGHeekVyBUnC 

## Commands
#### Rebuild nixos with the flake
- sudo nixos-rebuild switch --flake .#nixos

#### Check flake configurations
- nix flake check --show-trace
