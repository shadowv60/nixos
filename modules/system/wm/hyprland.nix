{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Optional: Adds support for screen sharing and portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Link the config file using Home Manager
  home-manager.users.wolk.xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
}
