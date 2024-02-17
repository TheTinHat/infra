{ lib, pkgs, ... }:
with lib;
with pkgs;
{
  options.packages = {
    standard = mkOption {
      default = with pkgs; [
        age
        tree
        fd
        lazygit
        nerdfonts
        ripgrep
        sops
      ];
      description = "Standard packages";
    };
  };
}
