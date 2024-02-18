{ pkgs, config, ... }: {
  imports = [
    ../mixins/packages.nix
  ];

  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    stateVersion = "23.11";
    packages = with pkgs; with config; packages.core ++
      [
        # Package
      ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      myip = "curl ifconfig.me && echo -e ''";
    };
  };

  programs.git = {
    enable = true;
    userName = "David Swanlund";
    userEmail = "10473778+TheTinHat@users.noreply.github.com";
  };

  programs.home-manager.enable = true;
}
