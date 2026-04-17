{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true; # Optional: auto-cd on quit
    enableFishIntegration = true;
    shellWrapperName = "y";

    # Your yazi.toml logic
    settings = {
      mgr = {
        show_hidden = false;
      };

      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
            desc = "Neovim";
            for = "unix";
          }
        ];
        play = [
          {
            run = ''mpv "$@"'';
            orphan = true;
            desc = "MPV";
            for = "unix";
          }
        ];
        zen-beta = [
          {
            run = ''zen-beta "$@"'';
            orphan = true;
            desc = "zen-beta";
            for = "unix";
          }
        ];
      };

      open = {
        prepend_rules = [
          {
            mime = "inode/directory";
            use = "open";
          }
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "application/javascript";
            use = "edit";
          }
          {
            mime = "application/json";
            use = "edit";
          }
          {
            name = "*.{md,txt,conf,toml,yaml,yml,lua,fish,py,rs}";
            use = "edit";
          }
          {
            mime = "audio/*";
            use = "play";
          }
          {
            mime = "video/*";
            use = "play";
          }
          {
            mime = "*";
            use = "zen-beta";
          }
        ];
      };
    };

    # Your theme.toml logic
    theme = {
      flavor = {
        dark = "gruvbox";
      };
    };

    # Handling the custom flavor file (flavor.toml)
    # This writes your gruvbox flavor to the correct location
    flavors = {
      gruvbox = ./yazi-flavors/gruvbox;
    };
  };
}
