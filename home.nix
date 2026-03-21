{ config, pkgs, inputs, ... }:

let
  pkgsList = import ./modules/system/packages.nix { inherit pkgs inputs; };
in
{
  home.username = "wolk";
  home.homeDirectory = "/home/wolk";
  home.stateVersion = "25.11";

  home.sessionPath = [ "$HOME/.local/bin" ];

  # Clean and simple
  imports = [
    ./modules/home-manager
  ];

  home.packages = pkgsList.userPackages;
}
