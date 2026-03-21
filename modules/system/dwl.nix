{ pkgs, ... }:

let
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
      # Renamed these to fix deprecation warnings:
      libxcb
      libxcb-wm
      libxcb-errors
      libcap
    ];

    # Updated system reference to fix evaluation warning
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
  environment.systemPackages = [ dwl-custom ];
  services.displayManager.sessionPackages = [ dwl-custom ];
}
