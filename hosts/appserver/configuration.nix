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
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/2 * * * * admin /home/admin/compose/servarr/update.sh"
    ];
  };

  services.resolved.enable = true;

  networking.hostName = "appserver"; # Define your hostname.
  networking.nameservers = [ "100.100.100.100" "45.90.28.73" "45.90.30.73" ];

  system.stateVersion = "24.05";

  systemd.services."docker".after = [ "network.target" "nfs-client.target" "mnt-appdata.mount" "mnt-david.mount" "mnt-media.mount" ];

  users.users.admin = {
    extraGroups = [ "docker" ];
  };

  virtualisation.docker.liveRestore = false;
}

