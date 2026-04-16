#!/usr/bin/env bash
VERSION=$(curl -s -A "Mozilla/5.0" https://api.github.com/repos/spotbye/SpotiFLAC/releases/latest | grep '"tag_name"' | cut -d'"' -f4 | tr -d 'v')
HASH=$(nix-prefetch-url "https://github.com/spotbye/SpotiFLAC/releases/download/v${VERSION}/spotiflac-linux-bundle.tar.gz" 2>/dev/null)
SRI=$(nix hash convert --hash-algo sha256 --to sri "$HASH")
sed -i "s/version = \".*\"/version = \"${VERSION}\"/" ~/nixos-dotfiles/pkgs/spotiflac.nix
sed -i "s|hash = \"sha256-.*\"|hash = \"${SRI}\"|" ~/nixos-dotfiles/pkgs/spotiflac.nix
echo "Updated to v${VERSION} with hash ${SRI}"
