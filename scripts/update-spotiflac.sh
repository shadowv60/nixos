#!/usr/bin/env bash
VERSION=$(curl -s https://api.github.com/repos/afkarxyz/SpotiFLAC/releases/latest | grep tag_name | cut -d'"' -f4 | tr -d 'v')
HASH=$(nix-prefetch-url "https://github.com/afkarxyz/SpotiFLAC/releases/download/v${VERSION}/SpotiFLAC.AppImage" 2>/dev/null)
SRI=$(nix hash convert --hash-algo sha256 --to sri "$HASH")
sed -i "s/version = \".*\"/version = \"${VERSION}\"/" ~/nixos-dotfiles/pkgs/spotiflac.nix
sed -i "s|hash = \"sha256-.*\"|hash = \"${SRI}\"|" ~/nixos-dotfiles/pkgs/spotiflac.nix
echo "Updated to v${VERSION} with hash ${SRI}"
