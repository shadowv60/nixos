{ pkgs, inputs, ... }:
{
  systemPackages = with pkgs; [
    wget
    git
    swaybg
    playerctl
    wl-clipboard
    libmtp
    mtpfs
    kdePackages.kio-extras
    android-tools
    tree
    appimage-run
    ffmpeg
    inputs.self.packages.${pkgs.system}.spotiflac
  ];
  userPackages = with pkgs; [
    localsend
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    btop
    mpc
    kdePackages.dolphin
    grim
    slurp
    wlsunset
    hyprsunset
    docker-compose
    lazydocker
    android-file-transfer
    libreoffice-fresh
    qbittorrent
    telegram-desktop
    bottles
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
