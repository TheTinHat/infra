{ config, pkgs, ... }: {
  imports = [
    ../david.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
