{ config, pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/modules/home/editor/nvim";

  home.packages = with pkgs; [
    neovim
    tree-sitter
    ripgrep
    fd
    gcc
    nodejs
    unzip
    nil
    ruff
    pyright
    llvmPackages.clang-unwrapped
    cargo
    rustc
    rust-analyzer
    clippy
    rustfmt
    statix
    deadnix
    nixfmt
    lua-language-server
  ];
}
