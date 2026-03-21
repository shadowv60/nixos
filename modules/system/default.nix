{ ... }:

{
  imports = [
    ./dwl.nix
    ./slstatus.nix
    ./services.nix   # We will create this
    ./users.nix      # We will create this
    ./boot.nix       # We will create this
  ];
}
