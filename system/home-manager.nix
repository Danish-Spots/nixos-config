{ ... }:

{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.justin = {
            imports = [
                ../software/vscode.nix
            ];

            home = {
                username = "justin";
                homeDirectory = "/home/justin";

                stateVersion = "26.05";
            };
        };
    };
}