{
  stdenv,
  lib,
  autoPatchelfHook,
  copyDesktopItems,
  makeDesktopItem,
  qt6,
  libGL,
  libX11,
  libxcb,
  libXext,
  libxrender,
  libxkbcommon,
  zlib,
  openssl,
  dbus,
  fontconfig,
  freetype,
  udev,
  srcOverride,
}:
stdenv.mkDerivation {
  pname = "prismlauncher-cracked";
  version = "11.0.2-1";
  src = srcOverride;
  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
    qt6.wrapQtAppsHook
  ];
  buildInputs = [
    stdenv.cc.cc.lib
    qt6.qtbase
    qt6.qtsvg
    qt6.qtnetworkauth
    qt6.qtwayland
    libGL
    libX11
    libxcb
    libXext
    libxrender
    libxkbcommon
    zlib
    openssl
    dbus
    fontconfig
    freetype
    udev
  ];
  postUnpack = ''
    addAutoPatchelfSearchPath "$sourceRoot/lib"
  '';
  autoPatchelfIgnoreMissingDeps = [
    "libgallium*.so"
    "libtiff.so.5"
  ];
  dontWrapQtApps = true;
  installPhase = ''
        runHook preInstall
        mkdir -p $out/opt/prismlauncher-cracked
        cp -r . $out/opt/prismlauncher-cracked/
        mkdir -p $out/bin
        cat > $out/bin/prismlauncher-cracked << EOF
    #!/bin/sh
    exec $out/opt/prismlauncher-cracked/PrismLauncher --dir "\$HOME/.local/share/PrismLauncher" "\$@"
    EOF
        chmod +x $out/bin/prismlauncher-cracked
        runHook postInstall
  '';
  postFixup = ''
    wrapQtApp $out/opt/prismlauncher-cracked/PrismLauncher \
      --set QT_QPA_PLATFORM xcb \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          libGL
          udev
          openssl.out
          libX11
        ]
      }
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "prismlauncher-cracked";
      desktopName = "Prism Launcher (Cracked)";
      comment = "Minecraft launcher — offline/cracked fork";
      exec = "prismlauncher-cracked %u";
      icon = "prismlauncher";
      categories = [ "Game" ];
      mimeTypes = [ "x-scheme-handler/prism" ];
      startupNotify = true;
    })
  ];
  meta = {
    description = "PrismLauncher fork with offline/cracked account support";
    homepage = "https://github.com/Diegiwg/PrismLauncher-Cracked";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "prismlauncher-cracked";
  };
}
