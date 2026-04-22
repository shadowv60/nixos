{ pkgs, ... }:
{
  services.gvfs.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.displayManager.sessionPackages = [ pkgs.hyprland ];
  services.displayManager.ly.enable = true;
  virtualisation.docker.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.fish.enable = true;
  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.xwayland.enable = true;
}
