{ ... }:

{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.justin = {
            imports = [
                ../software
            ];

            home = {
                username = "justin";
                homeDirectory = "/home/justin";

                stateVersion = "26.05";
            };
        };
    };
}