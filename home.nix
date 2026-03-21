{ config, pkgs, inputs, ... }:

let
  pkgsList = import ./modules/system/packages.nix { inherit pkgs inputs; };
in

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

  services.mpd = {
    enable = true;
    musicDirectory = "/home/wolk/Music";
    dataDir = "/home/wolk/.local/share/mpd";
    
    # Let Home Manager handle the network binding
    network.listenAddress = "127.0.0.1";
    network.port = 6600;

    extraConfig = ''
      # Do NOT put bind_to_address or port in here
      auto_update "yes"
      restore_paused "yes"

      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }

      audio_output {
        type "fifo"
        name "cava_fifo"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };


  services.mpdris2.enable = true;

  # XDG Dotfiles Management
  home.file = {
    ".config/qtile".source = ./config/qtile;
    ".config/nvim".source = ./config/nvim;
    ".config/foot".source = ./config/foot;
    ".config/rofi".source = ./config/rofi;
    ".config/cava".source = ./config/cava;
    ".config/yazi".source = ./config/yazi;
    ".config/kitty".source = ./config/kitty;
    ".config/rmpc".source = ./config/rmpc;
  };
  
  home.packages = pkgsList.userPackages;
}

