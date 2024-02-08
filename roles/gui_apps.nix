{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bitwarden
    chromium
    darktable
    element-desktop
    firefox
    flatpak
    gimp
    gnome.gnome-tweaks
    inkscape
    qgis
    libreoffice
    prusa-slicer
    steam
    syncthing
    tor-browser-bundle-bin
    virt-manager
    vlc
    wireshark
    # obsidian # disabled as it uses insecure version of electron
  ];
}
