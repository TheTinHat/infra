{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../users/admin.nix
      ../../mixins/common.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.hostName = "apps"; # Define your hostname.
  nix.settings.trusted-users = [ "admin" ];
  services.resolved.enable = true;

  system.stateVersion = "24.11";

}


