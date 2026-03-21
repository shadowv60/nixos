{ config, lib, pkgs, inputs, ... }:

let
  pkgsList = import ../../modules/system/packages.nix { inherit pkgs inputs; };
in

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/dwl.nix
    ../../modules/system/slstatus.nix
  ];

  # Bootloader settings
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.device = "nodev";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  # 1. Enable GVFS (Essential for Dolphin to "see" network/mtp shares)
  services.gvfs.enable = true;

  # Window Managers & Display Manager
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };
  
  services.displayManager = {
    ly.enable = true;
    # Note: We will fix the sessionPackages below
  };

  # Sound & Printing
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  environment.sessionVariables = {
  XKB_DEFAULT_OPTIONS = "caps:escape";
 };

  programs.fish.enable = true;
  programs.dconf.enable = true;
  # Users
  users.users.wolk = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ]; 
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = pkgsList.systemPackages;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = pkgsList.nixLdLibraries;

  # Programs & System Packages
  programs.firefox.enable = true;
  programs.xwayland.enable = true;
  
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
