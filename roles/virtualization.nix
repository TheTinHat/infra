{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    OVMFFull
  ];

  programs.dconf.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
}
