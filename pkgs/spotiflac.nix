{
  appimageTools,
  webkitgtk_4_1,
  ffmpeg,
  glib-networking,
  gst_all_1,
  srcOverride,
}:
appimageTools.wrapType2 {
  pname = "spotiflac";
  version = "latest";
  src = srcOverride;
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
