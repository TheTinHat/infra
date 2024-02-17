{ config, pkgs, ... }: {
  imports = [
    ../david.nix
    ../../mixins/packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = config.packages.standard;
}
