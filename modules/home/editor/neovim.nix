{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = true;
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/modules/home/editor/nvim";
    recursive = false;
  };

  home.packages = with pkgs; [
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
    nixfmt # Changed from nixfmt-rfc-style to nixfmt as per warning
    lua-language-server
  ];
}
