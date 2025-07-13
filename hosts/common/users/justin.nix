{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.justin = {
    isNormalUser = true;
    description = "justin";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.justin = 
    import ../../../home/justin/${config.networking.hostName}.nix;
}