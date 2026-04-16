{ pkgs, ... }:

let
  slstatus-custom = pkgs.stdenv.mkDerivation rec {
    pname = "slstatus-custom";
    version = "master";

    src = ../../../pkgs/slstatus-src;

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      # Renamed from xorg.libX11 to libx11
      libx11
    ];

    installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

    makeFlags = [ "CC:=$(CC)" ];

    preBuild = ''
      make clean
    '';
  };
in
{
  environment.systemPackages = [ slstatus-custom ];
}
