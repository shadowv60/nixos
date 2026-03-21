{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name  = "shadowv60";
    settings.user.email = "shadowvpsl48@gmail.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fastfetch
    '';
    shellAliases = {
      v = "nvim";
      nos = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
      nix-clean = "nix-collect-garbage -d";
    };
  };
}
