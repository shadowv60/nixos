{ pkgs, inputs, ... }:
{
  systemPackages = with pkgs; [
    wget
    git
    rofi
    swaybg
    playerctl
    wl-clipboard
    libmtp
    mtpfs
    kdePackages.kio-extras
    android-tools
    tree
    waybar
  ];
  userPackages = with pkgs; [
    localsend
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    cava
    yazi
    btop
    mpc
    rmpc
    kdePackages.dolphin
    grim
    slurp
    wlsunset
    hyprsunset
    kitty
    foot
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
