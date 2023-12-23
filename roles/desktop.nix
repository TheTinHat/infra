{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    flatpak
    gnome.gnome-tweaks
    element-desktop
    bitwarden
    firefox
    qgis
    libreoffice
    tor-browser-bundle-bin
    chromium
    steam
    inkscape
    gimp
    virt-manager
    wireshark
    vlc
    syncthing
    prusa-slicer
    obsidian
    darktable
  ];

  programs.steam.enable = true;
  services.flatpak.enable = true;

  services.syncthing = {
    enable = true;
    user = "david";
    dataDir = "/home/david/";
  };
}
