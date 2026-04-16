{
  stdenv,
  fetchurl,
  appimage-run,
  webkitgtk_4_1,
  makeWrapper,
  ffmpeg,
  gst_all_1,
  glib-networking,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "spotiflac";
  version = "7.1.4";

  src = fetchurl {
    url = "https://github.com/spotbye/SpotiFLAC/releases/download/v${version}/spotiflac-linux-bundle.tar.gz";
    hash = "sha256-5L+okTBF4nJ+60O6y8YrPeSrpcNN3gxjFPVKdEyR8QU=";
  };

  nativeBuildInputs = [ makeWrapper ];

  # This avoids the manual 'tar' in unpackPhase
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    # Create a destination for the AppImage
    mkdir -p $out/opt/spotiflac
    cp SpotiFLAC-linux-bundle/SpotiFLAC-amd64.AppImage $out/opt/spotiflac/spotiflac.AppImage
    chmod +x $out/opt/spotiflac/spotiflac.AppImage

    # Use makeWrapper to call appimage-run on the specific path
    mkdir -p $out/bin
    makeWrapper ${appimage-run}/bin/appimage-run $out/bin/spotiflac \
      --add-flags "$out/opt/spotiflac/spotiflac.AppImage" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ webkitgtk_4_1 ]}" \
      --prefix PATH : "${lib.makeBinPath [ ffmpeg ]}" \
      --prefix GST_PLUGIN_PATH : "${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-good}/lib/gstreamer-1.0" \
      --prefix GIO_EXTRA_MODULES : "${glib-networking}/lib/gio/modules"

    runHook postInstall
  '';

  meta = {
    description = "Spotify to FLAC downloader";
    platforms = [ "x86_64-linux" ];
  };
}
