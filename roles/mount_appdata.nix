{ pkgs, ... }: {
  boot.initrd.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "nfs" ];

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems."/mnt/appdata" = {
    device = "192.168.1.200:/mnt/rust/appdata";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

}
