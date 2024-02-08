{ pkgs, ... }: {
  home.stateVersion = "23.11";
  home.username = "david";
  home.homeDirectory = "/home/david/";

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      work = "source env/bin/activate";
      mkenv = "python3 -m venv env";
      myip = "curl ifconfig.me && echo -e ''";
    };
  };

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
    enable = false;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      LazyVim
      neogit
      vim-nix
      vim-lsp
      vim-markdown
      editorconfig-vim
      nvim-treesitter.withAllGrammars      
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-markdown
          tree-sitter-nix
        ]
      ))
    ];
  };
}
