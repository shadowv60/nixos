{ config, pkgs, inputs, ... }:

{
  home.username = "wolk";
  home.homeDirectory = "/home/wolk";
  home.stateVersion = "25.11";

  # This ensures your scripts in .local/bin are actually executable from anywhere
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file.".local/bin".source = ./scripts;
  home.file.".local/bin".recursive = true;

  imports = [
    ./modules/home-manager/fastfetch.nix
  ];

  programs.git = {
    enable = true;
    settings.user.name  = "shadowv60";
    settings.user.email = "shadowvpsl48@gmail.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fastfetch
    '';
    shellAliases = {
      # Use "v" for nvim since you had it in your bash config
      v = "nvim";
      nos = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
      nix-clean = "nix-collect-garbage -d";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true; # Enable this if using a floating WM or X11
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # XDG Dotfiles Management
  home.file = {
    ".config/qtile".source = ./config/qtile;
    ".config/nvim".source = ./config/nvim;
    ".config/foot".source = ./config/foot;
    ".config/rofi".source = ./config/rofi;
    ".config/cava".source = ./config/cava;
    ".config/yazi".source = ./config/yazi;
    ".config/kitty".source = ./config/kitty;
  };

  home.packages = with pkgs; [
    # Neovim & Development
    neovim
    tree-sitter
    ripgrep
    gcc
    nodejs
    unzip
    
    # User Applications
    inputs.zen-browser.packages."${pkgs.system}".default
    cava
    yazi
    btop
    kitty
    
    # Wayland Utilities
    grim
    slurp
    wlsunset
  ];
}
