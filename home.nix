{ config, pkgs, inputs, ... }:

{
  home.username = "wolk";
  home.homeDirectory = "/home/wolk";
  home.stateVersion = "25.11";
  home.file.".local/bin".source = ./scripts;
  home.file.".local/bin".recursive = true;

  imports = [
    ./modules/home-manager/fastfetch.nix
    # You could also move dwl and slstatus imports here if they aren't in configuration.nix
  ];

  programs.git = {
  enable = true;
  userName  = "shadowv60";
  userEmail = "shadowvpsl48@gmail.com";
};


  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo kjsdskj";
      v = "nvim";
      nos = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
    };
    initExtra = ''
      fastfetch
      export PS1='[\u@\h:\w]\$ '
    '';
  };

  # XDG Dotfiles Management
  home.file = {
    ".config/qtile".source = ./config/qtile;
    ".config/nvim".source = ./config/nvim;
    ".config/foot".source = ./config/foot;
    ".config/rofi".source = ./config/rofi;
    ".config/cava".source = ./config/cava;
    ".config/yazi".source = ./config/yazi;
    # Removed fastfetch source here because fastfetch.nix handles it now
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
    
    # Wayland Utilities
    grim
    slurp
    wlsunset
    # fastfetch is already included via programs.fastfetch.enable in fastfetch.nix
  ];
}

