{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.bash.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos/infra/hosts/#$(hostname) --upgrade";
    nsync = "sudo chown -R root:wheel /etc/nixos/ && git --git-dir /etc/nixos/infra/.git pull";
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    lazygit
    ripgrep
    rsync
    tailscale
    wget
  ];

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  security.sudo.extraRules = [
    {
      users = [ "david" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services.tailscale.enable = true;

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

}
