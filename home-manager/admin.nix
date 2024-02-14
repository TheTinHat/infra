{ pkgs, ... }: {

  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    packages = with pkgs; [
      age
      fd
      lazygit
      nerdfonts
      ripgrep
      sops
      tree
    ];
    stateVersion = "23.11";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      infra = "git clone https://github.com/thetinhat/infra.git ~/infra";
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
