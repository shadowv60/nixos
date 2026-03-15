#!/bin/sh

# Add your custom scripts folder to the PATH so dwl/slstatus can find them
export PATH="$PATH:/home/wolk/nixos-dotfiles/config/status"

# Check if slstatus is available in the Nix store path
if command -v slstatus >/dev/null; then
  # Start slstatus in 's' (stdout) mode and pipe to dwl
  slstatus -s | dwl
else
  # Fallback: simple clock piped to dwl if slstatus isn't found
  while true; do
    date +'%H:%M'
    sleep 60
  done | dwl
fi
