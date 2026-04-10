{
  stdenv,
  gst_all_1,
  fetchurl,
  appimage-run,
  webkitgtk_4_1,
  makeWrapper,
  ffmpeg,
  glib-networking,
}:

stdenv.mkDerivation rec {
  pname = "spotiflac";
  version = "7.1.3";

  src = fetchurl {
    url = "https://github.com/afkarxyz/SpotiFLAC/releases/download/v${version}/SpotiFLAC.AppImage";
    hash = "sha256-3IjUblz61MuternDg2oqfkrs/gSlq0I9oqmE0oZGrsM=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    ln -s $src $out/bin/SpotiFLAC.AppImage
    makeWrapper ${appimage-run}/bin/appimage-run $out/bin/spotiflac \
      --add-flags "$out/bin/SpotiFLAC.AppImage" \
      --prefix LD_LIBRARY_PATH : "${webkitgtk_4_1}/lib" \
      --prefix PATH : "${ffmpeg}/bin" \
      --prefix GST_PLUGIN_PATH : "${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0" \
      --prefix GIO_EXTRA_MODULES : "${glib-networking}/lib/gio/modules"
  '';

  meta.platforms = [ "x86_64-linux" ];
}
