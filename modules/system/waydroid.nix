{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  networking.firewall.trustedInterfaces = [ "waydroid0" ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;
  };

  boot.kernelModules = [ "kvm-intel" ];
}
