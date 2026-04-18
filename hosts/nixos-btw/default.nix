{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  pkgsList = import ../../modules/system/packages.nix { inherit pkgs inputs; };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system # Points to modules/system/default.nix
  ];

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Package and Nix settings
  environment.systemPackages = pkgsList.systemPackages;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = pkgsList.nixLdLibraries;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
