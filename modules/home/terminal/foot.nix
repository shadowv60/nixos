{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono Nerd Font:size=12";
      };

      colors-dark = {
        alpha = 0.85;
        foreground = "bbb49d";
        background = "1e2224";
        regular0 = "1e2224"; # black
        regular1 = "636862"; # red
        regular2 = "85867a"; # green
        regular3 = "bbb49d"; # yellow
        regular4 = "636862"; # blue
        regular5 = "85867a"; # magenta
        regular6 = "bbb49d"; # cyan
        regular7 = "bbb49d"; # white

        bright0 = "49504f"; # bright black
        bright1 = "85867a"; # bright red
        bright2 = "bbb49d"; # bright green
        bright3 = "ece6d9"; # bright yellow
        bright4 = "85867a"; # bright blue
        bright5 = "ece6d9"; # bright magenta
        bright6 = "ece6d9"; # bright cyan
        bright7 = "ffffff"; # bright white

        selection-foreground = "1e2224";
        selection-background = "bbb49d";
      };

      tweak = {
        font-monospace-warn = "no";
      };
    };
  };
}
