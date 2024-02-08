{ ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ../../roles/common.nix
      ../../roles/admin.nix
    ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "testbox";
}
