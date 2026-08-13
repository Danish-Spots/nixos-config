{ pkgs, ... }:

{
  programs.vscode = {
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];

      userSettings = {
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "alejandra";
        "chat.disableAIFeatures" = true;
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "alejandra" ];
            };

            "options" = {
              "nixos" = {
                expr = ''
                    (builtins.getFlake "''${workspaceFolder}").nixosConfigurations.nixos.options
                  '';
              };
              "home-manager" = {
                expr = ''
                    (builtins.getFlake "''${workspaceFolder}").nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []
                  '';
              };
            };
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    nixd
    alejandra
  ];
}