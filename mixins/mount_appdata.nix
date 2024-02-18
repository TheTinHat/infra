{ pkgs, ... }: {
  boot.initrd.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "nfs" ];

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems."/mnt/appdata" = {
    device = "rust.wolf-atlas.ts.net:/mnt/rust/appdata";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
}
