{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  fileSystems."/mnt/david" = {
    device = "//192.168.1.200/david";
    fsType = "cifs";
    options = [ "credentials=/etc/nixos/smb-secrets" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
  };
}
