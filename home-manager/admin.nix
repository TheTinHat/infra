{ ... }: {
  home.stateVersion = "23.11";

  home = {
    username = "admin";
    homeDirectory = "/home/admin";
  };

  programs.bash = {
    enable = true;
    shellAliases = { };
  };

  programs.git = {
    enable = true;
    userName = "David Swanlund";
    userEmail = "10473778+TheTinHat@users.noreply.github.com";
  };
}
