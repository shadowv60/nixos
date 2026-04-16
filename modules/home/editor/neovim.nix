{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    tree-sitter
    ripgrep
    fd
    gcc
    nodejs
    unzip
    # LSP servers
    nil
    ruff
    pyright
    llvmPackages.clang-unwrapped
    # Rust
    cargo
    rustc
    rust-analyzer
    clippy
    rustfmt
    # Nix tools
    statix
    deadnix
    nixfmt
    # Lua
    lua-language-server
  ];
}
