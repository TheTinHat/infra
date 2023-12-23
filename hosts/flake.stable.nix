# /etc/nixos/flake.nix
{
  description = "Flake for stable infrastructure";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-stable";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      rusty = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./rusty/configuration.nix
        ];
      };
    };
  };
}
