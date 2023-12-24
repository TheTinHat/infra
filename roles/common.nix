{ pkgs, ... }:

{
  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos/infra/hosts/#$(hostname)";
  };

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
}
