{ pkgs, ... }: {
  imports = [
    ../david.nix
    ../../mixins/gc_optimise.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    age
  ];
}
