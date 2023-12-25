{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../roles/common.nix
      #../../users/david.nix
    ];

  system.stateVersion = "23.11";

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "minimal"; # Define your hostname.
}
