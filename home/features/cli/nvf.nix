{
  config,
  inputs,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.nvf;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options.features.cli.nvf.enable = mkEnableOption "Enable nvf -  neovim implementation";
  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          git = {gitsigns = {enable = true;};};
          theme = {
            enable = true;
            name = "nord";
            style = "cool";
          };
          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete = {
            blink-cmp = {
              enable = true;
              friendly-snippets.enable = true;
            };
          };
          filetree = {
            neo-tree.enable = true;
          };
          binds = {
            whichKey = {
              enable = true;
            };
          };
          lsp = {
            enable = true;
            formatOnSave = true;
          };
          languages = {
            enableTreesitter = true;
            enableFormat = true;
            nix = {
              enable = true;
              format.enable = true;
              lsp.enable = true;
              # lsp.server = "nixd";
              treesitter.enable = true;
            };
            ts.enable = true;
          };
          utility = {snacks-nvim = {enable = true;};};
        };
      };
    };
  };
}
