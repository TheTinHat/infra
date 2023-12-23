{ pkgs, ... }:

{
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    htop
    rsync
    tailscale
    unzip
    wget
  ];

  services.tailscale.enable = true;

  system.stateVersion = "23.11";
}
