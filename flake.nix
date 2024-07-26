# /etc/nixos/flake.nix
{
  description = "Flake for stable infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixinate.url = "github:matthewcroughan/nixinate";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, sops-nix, nixinate }: {
    apps = nixinate.nixinate.x86_64-linux self;
    nixosConfigurations = {
      installIso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./mixins/common.nix
          {
            users.users.nixos.openssh.authorizedKeys.keys = [
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtFbUEM9Ways1zGCo9SnO2KsoAFw0HBm7OBc55Zqtd5IIdoi7Fb6oeM4+yNceaGwlX9jT30h/VV42iyhAgeIwOrD0ZWsGzvY8AsgIOVg5V5IkUdR4TXtFxHGiu2TegOMD5GzbIN+aOr0erwZ9zfMmPA6AX4zrVk4L6juklgYn/sqpRaTraY+LDDo/mcZ42NG2+ULRcZczvDR5Gd0y+IrNbojitvx3lRjWRIUy6beR6XDtWmACFt0FvoVo8bZd5P1ZIzyzQDWByPtKTf3lKbC7dqnE7HbrqPMTmYXRfOguqQQzg+BEac8Wsl/zEcQ6bTlSWT547yKtuT+/z/haeH+M+SxYF2YYC6ViKf8px/IxCl2sZOuzNTreySKyEN2K+vOLbH/GmY7FuqNpEUEvWN77lt6dEB3gFZiVBc2i6P+73X2ZxQbhWZ/kLDAPbD8+vE29jl5TIS66sLZLQr/+rUWoT3wU7eB8rDOLbYL31stqOEZJTmBU3x2wh7jiz6+Ae7FE="
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAvENFN5we3/+8NDeTITvURMhux19udOeKzmco9bBaXNK0d5gzDyzEShC0hWYEfWmtSvWBCLb+RV4k0rC5yfVeA6Y0ePHUGPMMNtBiFhV1ZDXrvCYOArsFSJbuUWWTgBGhIGt8MjqgBxfP1ukp+ucKvGOcOjLXXA+TTNKz97s5brJ+lbJwT00S1l1StihD6r6dZuumRblVGO59mLemvj9n+K1ewYL3Dnz88i4PXpzeBarjIdxhCoqf3f+i/7JzJUVdfK2zIOId9aE8W6wG6vqSDV6R1gc4EiW2wuPpmNh/UKj3R+Mrtr4CO6z1ZY8azgbTr4AMAWpQbRjvIZE241j06PETLJ1Bte4veU3vJHsRlpUEz5XGs43114U0tzDMyqtocwpdBUkK6bal0M0gzZZ/rbPDMAVj53Yt1TtGkh0Wu4FlNuaZzkDY/VzLg+N15KHcgpKnDM/So+k8vA20aD64od73pZ7dOAI0w9i2rbHCiSVPu00SlMf4ua9RDDtf8ks="
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMSlTkMIZSjEEVsqcRTtlOH5EOMKKHhVkiS/o7m4a4znIs705ObhNKXf91PW3zX3iyBZhUQGHiszzCvQz6tOTG9pYKk7/19njLjcbtbZpBBqL1O5kGmIu13GQ9R8kye+RmCnZMjydfO84GtvFOqE32xLe1sOm8pSS4rHCR+0LUAcxSa9eYJUbKY2vk90q0P5CVrAyd+XLYwxypc4qyPkLVc/ZyQh+I/VlaPpNFNfkoTVZYAGMvEq0/TjyZ5esZ1VG2oyqkweh+hPfq3+vVKKC15EoheyVehrG2foHbgqfDrY0cwXEjpLGajYEhlJNjw1YQt0eK6ipV6R2pvlnvcmgJB1wsROouhD8V0wSqF7VZ+OIEfPitnYmLvUX0ZGnc+PykbYnzEZfsdh/5khsv37G+0DU7kjdLdzg8NjpkBFiG3WPG3xy4+9HSQb80lWic2i22yZISiyioVrqvdFeGK4OfOgQyMaw9dI+q9PU9Qgxm+BycSgchlU7mLW2cD1wSxgc="
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDqQCk4jxmAwOXXkwApL0gv0FZR6YjstShbEUTts4IteY09XeagrUaaYqI3Qkc3K32UdHOQhrK710ar5UaTqMu2uGDuoyh0PDgbmTG5aaVQBIPOwwI2BH4oAOpdr/BTtoRJR/cOTJ5EaTgRPEiWdWRaiBTMbkoUiJhW0U4rhUAKlQnCvKi4YFWhzLnJ2U+uDbPmuCC/hT0XVxtQRT9v4drKQjHYeLM33TBigfFMjdsSSLBamNbg8E1mDfPQ8Einxc9tlM452M/kao0ncTowuXtF25dGWakgGzfTfdXhpTz80PirpS0zqBjEQrwyFdvYK06xCqBP6/mROpRxr4k+eVfFlM5ZzwuTQKa+WZjY8CWRisvxkcGRI+6pf0CottQCzXY1k/Uj5gLl+lHzf9FYhs4GbZaOKnEl5GDfsfYvJ8A/6qRJQOosamZSMm2pF6gLhwonBlMdZaHi/QhsOIbNIJvRpPP6hk/+r5uQvgiI2MV+G7HFcH1wVveALJnS0b6kL+U="
            ];
          }
        ];
      };
      testbox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/testbox/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
      monitoring = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/monitoring/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
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
          }
        ];
      };
      workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/workstation/configuration.nix
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
    homeConfigurations = {
      "david@work" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        modules = [
          ./home-manager/standalone/david.work.nix
          sops-nix.homeManagerModules.sops
        ];
      };
      "david@macos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        modules = [
          ./home-manager/standalone/david.macos.nix
          sops-nix.homeManagerModules.sops
        ];
      };
    };
  };
}
