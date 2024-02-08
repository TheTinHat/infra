{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos/infra/hosts/#$(hostname) --upgrade-all";
    ncd = "cd /etc/nixos/infra/";
    nsync = "sudo chown -R david:users /etc/nixos/ && git --git-dir /etc/nixos/infra/.git pull";
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    lazygit
    ripgrep
    rsync
    wget
  ];

  services.tailscale.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
}
