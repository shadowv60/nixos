{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "shadowv60";
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
      nix-clean = "sudo nix-env --delete-generations +1 --profile /nix/var/nix/profiles/system && nix-env --delete-generations +1 && sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
  };
}
