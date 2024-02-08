{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ../../roles/common.nix
      ../../roles/autoupgrade.nix
      ../../roles/mount_appdata.nix
      ../../users/admin.nix
    ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "appserver"; # Define your hostname.

  environment.systemPackages = with pkgs; [
  ];

}

