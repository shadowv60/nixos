{ pkgs, inputs, ... }:
{
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
  userPackages = with pkgs; [
    localsend
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    cava
    yazi
    btop
    kitty
    mpc
    rmpc
    kdePackages.dolphin
    grim
    slurp
    wlsunset
  ];
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
