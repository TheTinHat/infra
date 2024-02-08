{ pkgs, ... }:
{
  imports =
    [
     ./hardware-configuration.nix
      ../../users/david.nix
      ../../roles/common.nix
      ../../roles/desktop.nix
      ../../roles/sudo_nopasswd.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-3538d39a-6a5b-481e-a85a-f25141900c7b".device = "/dev/disk/by-uuid/3538d39a-6a5b-481e-a85a-f25141900c7b";
  boot.initrd.luks.devices."luks-3538d39a-6a5b-481e-a85a-f25141900c7b".keyFile = "/crypto_keyfile.bin";

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
    libreoffice
    obsidian 
    OVMFFull
    prusa-slicer
    qgis
    steam
    syncthing
    tor-browser-bundle-bin
    virt-manager
    vlc
    wireshark
  ];

  networking.hostName = "workstation"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "david";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Nvidia Driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Printer
  services.printing.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "david";
    dataDir = "/home/david/";
  };

  system.stateVersion = "23.11";

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  # Virtualization
  programs.dconf.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.dates = "monthly";
}
