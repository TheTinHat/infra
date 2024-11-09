{ pkgs, config, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../users/david.nix
      ../../mixins/common.nix
      ../../mixins/docker.nix
      ../../mixins/gc_optimise.nix
      ../../mixins/packages.nix
      ../../mixins/mount_media.nix
      ../../mixins/mount_david.nix
    ];

  _module.args.nixinate = {
    host = "workstation";
    sshUser = "david";
    buildOn = "remote";
    substituteOnTarget = true;
    hermetic = false;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-3538d39a-6a5b-481e-a85a-f25141900c7b".device = "/dev/disk/by-uuid/3538d39a-6a5b-481e-a85a-f25141900c7b";
  boot.initrd.luks.devices."luks-3538d39a-6a5b-481e-a85a-f25141900c7b".keyFile = "/crypto_keyfile.bin";

  environment.systemPackages = with pkgs; config.packages.gui ++ [
    # gnome.gnome-tweaks
    kcalc
  ];

  hardware.opengl = {
    enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  networking.hostName = "workstation"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Add steam here rather than via package install so settings are correctly applied
  programs.steam.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable KDE Plasma6
  services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasmax11";

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "david";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Nvidia Driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.forceFullCompositionPipeline = true;
  
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

  system.stateVersion = "24.05";

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  # Virtualization
  programs.dconf.enable = true;
  virtualisation.libvirtd.enable = true;
}
