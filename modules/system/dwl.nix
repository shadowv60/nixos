{ pkgs, ... }:

let
  # Move your package definition into a 'let' block
  dwl-custom = pkgs.stdenv.mkDerivation rec {
    pname = "dwl-custom";
    version = "master";

    src = ../../pkgs/dwl-src;

    nativeBuildInputs = with pkgs; [
      pkg-config
      wayland-scanner
    ];

    buildInputs = with pkgs; [
      wayland
      wayland-protocols
      wlroots_0_19 
      libinput
      libxkbcommon
      pixman
      fcft
      libdrm
      xorg.libxcb
      xorg.xcbutilwm
      xorg.xcbutilerrors
      libcap
    ];

    NIX_CFLAGS_COMPILE = [ "-I${pkgs.libdrm}/include/libdrm" ];

    installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

    postInstall = ''
      mkdir -p $out/share/wayland-sessions
      cp dwl.desktop $out/share/wayland-sessions/
      
      cp dwl.sh $out/bin/dwl-run
      chmod +x $out/bin/dwl-run
    '';

    passthru.providedSessions = [ "dwl" ];

    makeFlags = [ "CC:=$(CC)" ];
  };
in
{
  # Now tell NixOS to actually install this package and recognize the session
  environment.systemPackages = [ dwl-custom ];
  services.displayManager.sessionPackages = [ dwl-custom ];
}
