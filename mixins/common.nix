{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    age
    curl
    gcc
    git
    htop
    rsync
    tailscale
    neovim
    wget
  ];

  environment.shellAliases = {
    infra = "git clone https://github.com/thetinhat/infra.git ~/infra";
    myip = "curl ifconfig.me && echo -e ''";
  };

  services.tailscale.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
}
