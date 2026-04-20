{
  stdenv,
  autoPatchelfHook,
  buildFHSEnv,
  srcOverride,
  libGL,
  zlib,
  fontconfig,
  libx11,
  libxext,
  libxrender,
  libXtst,
  libxi,
  wayland,
  alsa-lib,
  freetype,
}:
let
  pname = "ab-download-manager";
  version = "1.8.7";
  unpacked = stdenv.mkDerivation {
    name = "${pname}-${version}-unpacked";
    src = srcOverride;
    nativeBuildInputs = [ autoPatchelfHook ];
    buildInputs = [
      libGL
      zlib
      fontconfig
      libx11
      libxext
      libxrender
      libXtst
      libxi
      wayland
      alsa-lib
      freetype
      stdenv.cc.cc.lib
    ];
    installPhase = ''
      mkdir -p $out/opt/${pname}
      cp -r . $out/opt/${pname}
      chmod +x $out/opt/${pname}/bin/ABDownloadManager
    '';
  };
in
buildFHSEnv {
  name = pname;
  targetPkgs =
    pkgs: with pkgs; [
      libGL
      zlib
      fontconfig
      libx11
      libxext
      libxrender
      libXtst
      libxi
      wayland
      alsa-lib
      freetype
      stdenv.cc.cc.lib
    ];
  runScript = "${unpacked}/opt/${pname}/bin/ABDownloadManager";
  extraBwrapArgs = [
    "--bind"
    "/run/user"
    "/run/user"
    "--setenv"
    "JAVA_TOOL_OPTIONS"
    "-Dawt.toolkit.name=WLToolkit"
  ];
  meta = {
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
