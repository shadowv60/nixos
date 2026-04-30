{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "data";
        source = ''
          $1          ▗▄▄▄        $2.*#&.    ,~=,
          $1          ▜███▙       $2&*+)^  %*^@*
          $1           ▜███▙       $2>=-@\/%*$)
          $1            ▜███▙       $2}(!-)$^]
          $1     ▟█████████████████▙ $2&(#@)/     $1▟▙
          $1    ▟███████████████████▙ $2$]<$\    $1▟██▙
          $2           ,___,           !)::&  $1▟███▛
          $2          [$*@#           %#!$ $1▟███▛
          $2         &*%!^                \/ $1▟███▛
          $2/)(*&!#$_#>)* $1▟██████████▙
          $2\!@#*@#%<>?&                  $1▟███████████▛
          $2      *}^#* $1▟▙                ▟███▛
          $2     &[!@) $1▟██▙              ▟███▛
          $2    /#$)$  $1▜███▙            ▝▀▀▀▀
          $2    <][(    $1▜███▙ $2%&!~)$&!_)$*!@#$(<>/
          $2     ^@      $1▟████▙ $2^?><!#$!(*&%!_%^)/
          $1           ▟██████▙       $2*(!)\
          $1          ▟███▛▜███▙       $2{>@%!
          $1         ▟███▛  ▜███▙       $2&^#$|
          $1         ▝▀▀▀    ▀▀▀▀▘       $2"*="
        '';
        position = "left";
        color = {
          "1" = "blue";
          "2" = "green";
        };
      };
      display = {
        separator = " · ";
        color = {
          title = "green";
          keys = "white";
        };
        bar = {
          width = 10;
          char = {
            elapsed = "■";
            total = "─";
          };
        };
      };
      modules = [
        {
          type = "title";
          format = "{user-name-colored}@{host-name-colored}";
          color = {
            user = "green";
            at = "white";
            host = "blue";
          };
        }
        "break"
        # {
        #   type = "disk";
        #   key = "DISK";
        #   keyColor = "blue";
        #   format= "wolk";
        # }
        {
          type = "disk";
          key = "├ disk";
          folders = "/";
        }
        # {
        #   type = "display";
        #   key = "├ res ";
        # }
        "break"
        {
          type = "os";
          key = "OS";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "├ krnl";
        }
        {
          type = "uptime";
          key = "└ up  ";
        }
        "break"
        {
          type = "host";
          key = "PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "├ cpu ";
          temp = true;
        }
        {
          type = "gpu";
          key = "├ gpu ";
          driverSpecific = true;
        }
        {
          type = "memory";
          key = "├ ram ";
          format = "{1} / {2} - {4}";
        }
        {
          type = "swap";
          key = "└ swap";
          format = "{1} / {2} - {4}";
        }
        "break"
        {
          type = "packages";
          key = "PKGS";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "├ wm  ";
        }
        {
          type = "terminal";
          key = "├ term";
        }
        {
          type = "shell";
          key = "├ sh  ";
        }
        {
          type = "editor";
          key = "└ edit";
          format = "nvim";
        }
      ];
    };
  };
}
