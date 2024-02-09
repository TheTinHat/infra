{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../users/admin.nix
      ../../roles/common.nix
      #      ../../roles/autoupgrade.nix
      ../../roles/mount_appdata.nix
    ];

  system.stateVersion = "23.11";

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "appserver"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    nginx
  ];
  services.nginx.enable = true;

}

