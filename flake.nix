# /etc/nixos/flake.nix
{
  description = "Flake for stable infrastructure";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixinate.url = "github:matthewcroughan/nixinate"; 
  };

  outputs = { self, nixpkgs, disko, home-manager, sops-nix, nixinate }: {
    apps = nixinate.nixinate.x86_64-linux self;
    nixosConfigurations = {
      testbox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/testbox/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          sops-nix.nixosModules.sops
        ];
      };
      monitoring = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/monitoring/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          sops-nix.nixosModules.sops
        ];
      };
      appserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/appserver/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            _module.args.nixinate = {
              host = "192.168.1.156";
              sshUser = "admin";
              buildOn = "remote"; 
              substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
              hermetic = false;
            };
          }
        ];
      };
      workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/workstation/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          sops-nix.nixosModules.sops
        ];
      };
    };
    homeConfigurations = {
      "work" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        modules = [
          ./home-manager/work.nix
          sops-nix.homeManagerModules.sops
        ];
      };
    };
  };
}
