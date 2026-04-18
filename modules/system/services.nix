{ pkgs, ... }:
{
  services.gvfs.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.displayManager.sessionPackages = [ pkgs.hyprland ];
  services.displayManager.ly.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "waydroid0" ];
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;
  };
  boot.kernelModules = [ "kvm-intel" ];
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
