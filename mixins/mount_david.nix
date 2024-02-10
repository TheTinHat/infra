{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  fileSystems."/mnt/david" = {
    device = "//192.168.1.200/david";
    fsType = "cifs";
    options = [ "x-systemd.automount" "noauto" ];
  };
}
