{ pkgs, ... }: {
  imports = [
    ../david.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    age
  ];
}
