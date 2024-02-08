{ pkgs, ... }:
{
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
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-markdown
          tree-sitter-nix
        ]
      ))
    ];
  };
}
