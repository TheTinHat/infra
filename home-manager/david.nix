{ pkgs, lib, config, ... }: {
  imports = [
    ../mixins/packages.nix
  ];

  home = {
    username = "david";
    homeDirectory =
      if pkgs.system == "aarch64-darwin"
      then "/Users/david/"
      else "/home/david";
    packages = with pkgs; with config; packages.core ++ packages.extra ++ packages.dev ++
      [
        # Package
      ];
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      work = "source env/bin/activate";
      mkenv = "python3 -m venv env";
      reqs = "pip install -r requirements.txt";
      myip = "curl ifconfig.me && echo -e ''";
      stress = "cat /dev/urandom | gzip > /dev/null";
    };
  };

  programs.dircolors.enable = true;

  programs.git = {
    enable = true;
    userName = "David Swanlund";
    userEmail = "10473778+TheTinHat@users.noreply.github.com";
  };

  services.gpg-agent =
    if pkgs.system == "aarch64-darwin" then
      { } else {
      enable = true;
      defaultCacheTtl = 43200;
      enableSshSupport = true;
    };


  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter
      nvim-treesitter.withAllGrammars
    ];
  };

  #sops = {
  # age.keyFile = "/home/david/.config/sops/age/key.txt";
  # age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];
  # defaultSopsFile = ../secrets/david.yaml;
  # secrets.test = {
  # sopsFile = ./secrets.yml.enc; # optionally define per-secret files

  # %r gets replaced with a runtime directory, use %% to specify a '%'
  # sign. Runtime dir is $XDG_RUNTIME_DIR on linux and $(getconf
  # DARWIN_USER_TEMP_DIR) on darwin.
  # path = "%r/test.txt"; 
  # };
  #
  #};
}
