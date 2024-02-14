{ pkgs, lib, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../users/admin.nix
      ../../mixins/common.nix
      ../../mixins/autoupgrade.nix
      ../../mixins/mount_appdata.nix
    ];

  _module.args.nixinate = {
    host = "monitoring";
    sshUser = "david";
    buildOn = "remote";
    substituteOnTarget = true;
    hermetic = false;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "monitoring"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  services = {
    uptime-kuma = {
      enable = true;
      settings = {
        HOST = "127.0.0.1";
        DATA_DIR = lib.mkForce "/mnt/appdata/kuma/kuma/data";
      };
    };

    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      virtualHosts."monitoring" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:3001/";
          proxyWebsockets = true;
        };

      };
    };
  };

  system.stateVersion = "23.11";
  systemd.services.uptime-kuma.after = [ "network.target" "nfs-client.target" "mnt-appdata.mount" ];
  systemd.services.uptime-kuma.serviceConfig = {
    ReadWritePaths = "/mnt/appdata/kuma/";
    TimeoutStopSec = 30;
  };
}
