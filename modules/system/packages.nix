{ pkgs, inputs, ... }:

{
  # System-wide packages (from configuration.nix)
  systemPackages = with pkgs; [
    wget
    git
    foot
    rofi
    swaybg
    playerctl
    wl-clipboard
    libmtp
    mtpfs
    kdePackages.kio-extras
    android-tools
    tree
  ];

  # User-specific packages (from home.nix)
  userPackages = with pkgs; [
    # Neovim & Development
    neovim
    tree-sitter
    ripgrep
    gcc
    nodejs
    unzip
    
    # User Applications
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    cava
    yazi
    btop
    kitty
    mpc
    rmpc
    kdePackages.dolphin

    # Wayland Utilities
    grim
    slurp
    wlsunset
  ];

  # Nix-LD Libraries
  nixLdLibraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];
}
