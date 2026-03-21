{ pkgs, ... }: {
  users.users.wolk = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ]; 
    shell = pkgs.fish;
  };

  time.timeZone = "Asia/Kolkata";

  environment.sessionVariables = {
    XKB_DEFAULT_OPTIONS = "caps:escape";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
