{ pkgs, ... }: {
  home.stateVersion = "23.11";
  
  home = {
    username = "david";
    homeDirectory = "/home/david";
    packages = with pkgs; [
      fd
      lazygit
      nerdfonts
      ripgrep
    ];
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      work = "source env/bin/activate";
      mkenv = "python3 -m venv env";
      reqs="pip install -r requirements.txt";
      myip = "curl ifconfig.me && echo -e ''";
      vi="nvim";
      vim="nvim";
    };
  };

  programs.dircolors.enable = true;

  programs.git = {
    enable = true;
    userName = "David Swanlund";
    userEmail = "10473778+TheTinHat@users.noreply.github.com";
  };

  services.gpg-agent = {
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
      LazyVim
      vim-nix
      vim-lsp
      vim-markdown
      editorconfig-vim
      nvim-treesitter.withAllGrammars      
    ];
  };
}
