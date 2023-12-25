{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../roles/common.nix
      ../../users/david.nix
      ../../roles/allow_ssh.nix
    ];


  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "testbox"; # Define your hostname.
}
