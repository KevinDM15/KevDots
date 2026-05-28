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

# Verificar dependencias mínimas
if ! command -v git &>/dev/null; then
  echo "Error: git no está instalado. Instalalo primero."
  exit 1
fi

if ! command -v zsh &>/dev/null; then
  echo "Error: zsh no está instalado. Instalalo primero."
  exit 1
fi

# Clonar o actualizar
if [ -d "$DEST/.git" ]; then
  echo "-> KevDots ya existe, actualizando..."
  git -C "$DEST" pull --ff-only
else
  echo "-> Clonando KevDots..."
  git clone "$REPO" "$DEST"
fi

echo ""
echo "-> Lanzando instalador..."
echo ""

exec zsh "$DEST/install.sh"
