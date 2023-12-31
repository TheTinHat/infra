{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../roles/common.nix
      ../../roles/allow_ssh.nix
    ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "monitoring"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  fileSystems."/mnt/appdata" = {
    device = "192.168.1.200:/mnt/rust/appdata";
    fsType = "nfs";
  };

  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "80";
      HOST = "monitoring.wolf-atlas.ts.net";
      DATA_DIR = "/mnt/appdata/kuma/kuma";
    };
  };
}
