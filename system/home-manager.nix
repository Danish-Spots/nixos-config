{ pkgs, ... }:

{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.justin = {
            home = {
                username = "justin";
                homeDirectory = "/home/justin";

                stateVersion = "26.05";

                packages = with pkgs; [
                    fastfetch
                ];
            };
        };
    };
}