{ config, pkgs, ... }:

{
  home.file = {
    ".config/qtile".source = ../../config/qtile;
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";
    ".config/foot".source = ../../config/foot;
    ".config/rofi".source = ../../config/rofi;
    ".config/hypr".source = ../../config/hypr;
    ".config/waybar".source = ../../config/waybar;
    ".config/cava".source = ../../config/cava;
    ".config/yazi".source = ../../config/yazi;
    ".config/kitty".source = ../../config/kitty;
    ".config/rmpc".source = ../../config/rmpc;
    ".local/bin".source = ../../scripts;
  };
  home.file.".local/bin".recursive = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
