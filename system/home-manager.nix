{ ... }:

{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.justin = {
            home.username = "justin";
            home.homeDirectory = "/home/justin";

            home.stateVersion = "26.05";
        };
    };
}