{
  appimageTools,
  webkitgtk_4_1,
  ffmpeg,
  glib-networking,
  gst_all_1,
  stdenv,
  srcOverride,
}:
let
  pname = "spotiflac";
  version = "latest";

  appimageSource = stdenv.mkDerivation {
    name = "${pname}-source";
    src = srcOverride;
    sourceRoot = ".";

    # We use a wildcard find to grab the AppImage regardless of the folder name
    installPhase = ''
      find . -name "*.AppImage" -exec cp {} $out \;
    '';
  };
in
appimageTools.wrapType2 {
  inherit pname version;
  src = appimageSource;

  extraPkgs =
    pkgs: with pkgs; [
      webkitgtk_4_1
      ffmpeg
      glib-networking
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
    ];

  meta = {
    platforms = [ "x86_64-linux" ];
    mainProgram = "spotiflac";
  };
}
