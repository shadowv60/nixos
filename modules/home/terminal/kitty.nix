{ ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 12;
    };
    settings = {
      # Eldritch Newsprint Theme
      foreground = "#bbb49d";
      background = "#1e2224";
      background_opacity = "0.85";

      selection_foreground = "#1e2224";
      selection_background = "#bbb49d";
      cursor = "#ece6d9";

      # Terminal Colors
      color0 = "#1e2224";
      color8 = "#49504f";
      color1 = "#636862";
      color9 = "#85867a";
      color2 = "#85867a";
      color10 = "#bbb49d";
      color3 = "#bbb49d";
      color11 = "#ece6d9";
      color4 = "#636862";
      color12 = "#85867a";
      color5 = "#85867a";
      color13 = "#ece6d9";
      color6 = "#bbb49d";
      color14 = "#ece6d9";
      color7 = "#bbb49d";
      color15 = "#ffffff";

      # Remote Control
      allow_remote_control = "yes";
    };
    extraConfig = ''
      # Fallback fonts
      symbol_map U+0B80-U+0BFF Noto Sans Tamil
      symbol_map U+1F600-U+1F64F Noto Color Emoji
    '';
  };
}
