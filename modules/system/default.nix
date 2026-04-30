{ ... }:

{
  imports = [
    ./wm
    ./services.nix # We will create this
    ./users.nix # We will create this
    ./boot.nix # We will create this
    ./vm.nix
    ./hardware.nix
    # ./waydroid.nix
    ./nix.nix
    ./dns.nix
  ];
}
