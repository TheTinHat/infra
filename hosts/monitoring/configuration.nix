{ pkgs, lib, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../roles/common.nix
      ../../roles/allow_ssh.nix
      ../../roles/autoupgrade.nix
    ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };

  networking.hostName = "monitoring"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    uptime-kuma
    nfs-utils
  ];

  fileSystems."/mnt/appdata" = {
    device = "192.168.1.200:/mnt/rust/appdata";
    fsType = "nfs";
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "monitoring.wolf-atlas.ts.net";
      DATA_DIR = lib.mkForce "/mnt/appdata/kuma/kuma/data";
    };
  };

  systemd.services.uptime-kuma.serviceConfig = {
    ReadWritePaths = "/mnt/appdata/kuma/";
  };
}
