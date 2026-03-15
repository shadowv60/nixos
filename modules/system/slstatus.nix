{ pkgs, ... }:

let
  slstatus-custom = pkgs.stdenv.mkDerivation rec {
    pname = "slstatus-custom";
    version = "master";

    src = ../../pkgs/slstatus-src;

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      xorg.libX11
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
