{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.nvf;
in {
  options.features.cli.nvf.enable = mkEnableOption "Enable nvf -  neovim implementation";

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
    };
  };
}
