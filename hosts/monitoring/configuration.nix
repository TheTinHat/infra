{ pkgs, lib, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../roles/common.nix
      ../../roles/allow_ssh.nix
      ../../roles/autoupgrade.nix
      ../../roles/mount_appdata.nix
    ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "monitoring"; # Define your hostname.

  networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 80 ];
  };
  networking.nat = {
    enable = true;
    internalInterfaces = [ "lo" ];
    externalInterface = "tailscale0";
    forwardPorts = [
      {
        sourcePort = 3001;
        proto = "tcp";
        destination = "127.0.0.1:80";
      }
    ];
  }; 

  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "monitoring.wolf-atlas.ts.net";
      DATA_DIR = lib.mkForce "/mnt/appdata/kuma/kuma/data";
    };
  };

  systemd.services.uptime-kuma.after = [ "network.target" "nfs-client.target" "mnt-appdata.mount" ];
  systemd.services.uptime-kuma.serviceConfig = {
    ReadWritePaths = "/mnt/appdata/kuma/";
    TimeoutStopSec = 30;
  };
}
