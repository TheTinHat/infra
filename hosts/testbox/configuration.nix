{ ... }: {
  imports = [
      ./hardware-configuration.nix
      ../../mixins/common.nix
      ../../users/admin.nix
    ];

  _module.args.nixinate = {
    host = "testbox";
    sshUser = "admin";
    buildOn = "remote"; 
    substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
    hermetic = false;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "testbox";

  system.stateVersion = "23.11";
}
