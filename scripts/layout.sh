#!/usr/bin/env bash

get_layout() {
  layout=$(hyprctl getoption general:layout | grep 'str:' | awk '{print $2}')
  case "$layout" in
  dwindle) echo "[]=" ;;
  master) echo "[T]=" ;;
  *) echo "[]=" ;;
  esac
}

get_layout

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" |
  while read -r line; do
    event="${line%%>>*}"
    case "$event" in
    activelayout | workspace | activewindow)
      get_layout
      ;;
    esac
  done
