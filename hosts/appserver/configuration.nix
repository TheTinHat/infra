{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../users/admin.nix
      ../../mixins/common.nix
      ../../mixins/mount_appdata.nix
      ../../mixins/mount_media.nix
      ../../mixins/mount_david.nix
      ../../mixins/docker.nix
      ../../mixins/gc_optimise.nix
      # ../../mixins/autoupgrade.nix
    ];

  _module.args.nixinate = {
    host = "appserver";
    sshUser = "admin";
    buildOn = "remote";
    substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
    hermetic = false;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "appserver"; # Define your hostname.

  system.stateVersion = "24.05";

  users.users.admin = {
    extraGroups = [ "docker" ];
  };

  systemd.services."docker".after = [ "network.target" "nfs-client.target" "mnt-appdata.mount" "mnt-david.mount" "mnt-media.mount" ];
}

