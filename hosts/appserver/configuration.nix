{ pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./disko-config.nix
      ../../users/admin.nix
      ../../mixins/common.nix
      ../../mixins/mount_appdata.nix
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

  system.stateVersion = "23.11";

  users.users.admin = {
    extraGroups = [ "docker" ];
  };

  config.virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer:portainer-ce:latest";
      ports = [ "80:8000" "443:9443" ];
      autoStart = true;
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/mnt/appdata/portainer:/data"
      ];
      cmd = [
      ];
    };
  };
}

