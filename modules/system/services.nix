{ pkgs, ... }:
{
  services.gvfs.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  services.displayManager.sessionPackages = [ pkgs.hyprland ];
  services.displayManager.ly.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Essential System Programs
  programs.fish.enable = true;
  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.xwayland.enable = true;
}
