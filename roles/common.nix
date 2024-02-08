{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    htop
    rsync
    tailscale
    wget
  ];

  services.tailscale.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
}
