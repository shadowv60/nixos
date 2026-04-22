{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
  environment.systemPackages = [ pkgs.virtiofsd ];
  services.samba = {
    enable = true;
    settings = {
      home = {
        path = "/home/wolk";
        readable = "yes";
        writable = "yes";
        "valid users" = "wolk";
      };
    };
  };
  services.samba-wsdd.enable = true;
  networking.firewall.interfaces."virbr0" = {
    allowedTCPPorts = [
      139
      445
    ];
    allowedUDPPorts = [
      137
      138
    ];
  };
}
