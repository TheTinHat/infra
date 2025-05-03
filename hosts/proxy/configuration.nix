{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../users/admin.nix
      ../../mixins/common.nix
      ../../mixins/gc_optimise.nix
      ../../mixins/mount_appdata.nix
      ../../mixins/mount_fastdata.nix
      ../../mixins/mount_media.nix
      ../../mixins/mount_david.nix
      # ../../mixins/autoupgrade.nix
    ];

  _module.args.nixinate = {
    host = "proxy";
    sshUser = "admin";
    buildOn = "remote";
    substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
    hermetic = false;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.hostName = "proxy"; # Define your hostname.
  networking.nameservers = [ "100.100.100.100" "45.90.28.73" "45.90.30.73" ];
  nix.settings.trusted-users = [ "admin" ];
  services.resolved.enable = true;

  system.stateVersion = "24.11";

  containers.pdf = {
    autoStart = true;
    ephemeral = true;
    privateNetwork = true;
    macvlans = [ "ens3" ];

    bindMounts = {
      "/var/lib/tailscale" = {
        hostPath = "/mnt/appdata/stirlingpdf/tailscale";
        isReadOnly = false;
      };
    };

    config = { config, pkgs, lib, ... }: {
      networking = {
        hostName = "pdf";
        useDHCP = lib.mkForce true;
        useHostResolvConf = false;
      };

      services = {
        stirling-pdf.enable = true;

        caddy = {
          enable = true;
          virtualHosts."pdf.wolf-atlas.ts.net".extraConfig = ''
            reverse_proxy localhost:8080
          '';
        };

        resolved.enable = true;

        tailscale = {
          enable = true;
          permitCertUid = "caddy";
          interfaceName = "userspace-networking";
        };
      };

      systemd.services.caddy = {
        after = [ "tailscaled.service" ];
        requires = [ "tailscaled.service" ];
      };

      system.stateVersion = "24.11";
    };
  };

  containers.media = {
    autoStart = true;
    config = { config, pkgs, ... }: {
      imports = [ ../../mixins/caddy_ts_proxy.nix ];
      networking.hostName = "media";
      services.caddy = {
        virtualHosts."media.wolf-atlas.ts.net".extraConfig = ''
          reverse_proxy http://rust.wolf-atlas.ts.net:8096
        '';
      };
      system.stateVersion = "24.11";
    };
  };
}


