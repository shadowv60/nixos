{ config, pkgs, ... }:

{
  home.file = {
    ".local/bin".source = ../../scripts;
  };
  home.file.".local/bin".recursive = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  xdg.desktopEntries.spotiflac = {
    name = "SpotiFLAC";
    exec = "spotiflac";
    icon = "spotify";
    categories = [
      "Audio"
      "Music"
    ];
  };

  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
