{ pkgs, ... }:

{
  home-manager.users.wolk = {
    programs.waybar = {
      enable = true;
      # This ensures Waybar is installed
      package = pkgs.waybar;
    };

    # Link the configuration and styling
    xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
    xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  };
}
