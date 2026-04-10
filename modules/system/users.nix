{ pkgs, ... }:
{
  users.users.wolk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "docker"
    ];
    shell = pkgs.fish;
  };

  time.timeZone = "Asia/Kolkata";

  # Configure keymap in X11 & Wayland
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape"; # This does the magic
  };

  # This maps it for the TTY (the console before you start dwl)
  console.useXkbConfig = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
