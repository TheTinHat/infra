{ pkgs, ... }: {
  boot.initrd.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "nfs" ];

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems."/mnt/fastdata" = {
    device = "192.168.1.200:/mnt/flash/fastdata";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
}
