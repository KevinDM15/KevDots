#!/bin/sh
# KevDots — curl installer
# Usage: curl -fsSL https://raw.githubusercontent.com/KevinDM15/KevDots/main/scripts/curl-install.sh | sh

set -e

REPO="https://github.com/KevinDM15/KevDots.git"
DEST="$HOME/KevDots"

echo ""
echo "KevDots installer"
echo "-----------------"
echo ""

if ! command -v git &>/dev/null; then
  echo "Error: git is not installed."
  exit 1
fi

if [ -d "$DEST/.git" ]; then
  echo "-> KevDots already exists, updating..."
  git -C "$DEST" pull --ff-only
else
  echo "-> Cloning KevDots..."
  git clone "$REPO" "$DEST"
fi

echo ""
echo "-> Launching installer..."
echo ""

exec zsh "$DEST/install.sh"
