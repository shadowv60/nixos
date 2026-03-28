{
  config,
  pkgs,
  inputs,
  ...
}:
let
  pkgsList = import ./modules/system/packages.nix { inherit pkgs inputs; };
  nvimPkgs = import ./modules/system/neovim.nix { inherit pkgs; };
in
{
  home.username = "wolk";
  home.homeDirectory = "/home/wolk";
  home.stateVersion = "25.11";
  home.sessionPath = [ "$HOME/.local/bin" ];
  imports = [
    ./modules/home-manager
  ];
  home.packages = pkgsList.userPackages ++ nvimPkgs.userPackages;
}
