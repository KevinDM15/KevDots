#!/bin/zsh
# KevDots — Backup Script
# Copia tu configuración actual al repo

set -e

DOTS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="$DOTS_DIR/config"

echo "🔵 KevDots Backup iniciando..."
echo "   Destino: $DOTS_DIR"
echo ""

backup() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$src" ]; then
    /bin/cp -rf "$src" "$dest"
    echo "  ✓ $src"
  else
    echo "  ✗ $src (no encontrado, omitido)"
  fi
}

echo "── Shell ──────────────────────────────"
backup ~/.zshrc                        "$CONFIG_DIR/zsh/.zshrc"
backup ~/.aliases                      "$CONFIG_DIR/zsh/.aliases"
backup ~/.config/zsh/env.zsh           "$CONFIG_DIR/zsh/env.zsh"
backup ~/.config/zsh/tools.zsh         "$CONFIG_DIR/zsh/tools.zsh"
backup ~/.config/zsh/prompt.zsh        "$CONFIG_DIR/zsh/prompt.zsh"

echo ""
echo "── Terminal ───────────────────────────"
backup ~/.config/alacritty             "$CONFIG_DIR/alacritty"
backup ~/.config/zellij                "$CONFIG_DIR/zellij"
backup ~/.config/starship.toml         "$CONFIG_DIR/starship.toml"

echo ""
echo "── Editor ─────────────────────────────"
backup ~/.config/nvim                  "$CONFIG_DIR/nvim"

echo ""
echo "── Herramientas ───────────────────────"
backup ~/.config/bat                   "$CONFIG_DIR/bat"
backup ~/.config/lsd                   "$CONFIG_DIR/lsd"
backup ~/.config/git                   "$CONFIG_DIR/git"

echo ""
echo "── Claude ─────────────────────────────"
backup ~/.claude/settings.json         "$CONFIG_DIR/claude/settings.json"
backup ~/.claude/CLAUDE.md             "$CONFIG_DIR/claude/CLAUDE.md"
backup ~/.claude/mcp.json              "$CONFIG_DIR/claude/mcp.json"
backup ~/.claude/skills                "$CONFIG_DIR/claude/skills"
backup ~/.claude/output-styles         "$CONFIG_DIR/claude/output-styles"

echo ""
echo "✅ Backup completado en $DOTS_DIR"
echo ""
echo "   Próximos pasos:"
echo "   cd ~/KevDots && git add . && git commit -m 'chore: backup $(date +%Y-%m-%d)'"
