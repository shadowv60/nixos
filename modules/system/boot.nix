{ pkgs, ... }:
let
  grub-gtg = pkgs.stdenv.mkDerivation {
    name = "grub-gtg";
    src = pkgs.fetchFromGitLab {
      owner = "imnotpua";
      repo = "grub_gtg";
      rev = "main";
      hash = "sha256-IqG//QgYc676Gw/R+UW5chKhxm0odf8FskmWT3vb3mo=";
    };
    nativeBuildInputs = [ pkgs.grub2 ];
    installPhase = ''
      mkdir -p $out
      grub-mkfont -s 23 -b assets/fonts/BankGothic.ttf -o $out/bankgothic.pf2
      cp assets/images/background.png $out/
      cp assets/menu/menu_*.png $out/
      cp assets/selection/select_*.png $out/
      cp assets/scrollbar/scrollbar_thumb_c.png $out/
      cp assets/theme.txt $out/
    '';
  };
in
{
  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    device = "/dev/sdb";
    theme = grub-gtg;
    useOSProber = true;
  };
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
