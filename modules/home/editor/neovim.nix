{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # Silence the 26.05 warnings
    withRuby = false;
    withPython3 = true; # Keep true if you use Python plugins in Nvim
  };

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/modules/home/editor/nvim";

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
