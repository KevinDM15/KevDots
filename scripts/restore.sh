#!/bin/zsh
# KevDots — Restore Script
# Instala tu configuración en una máquina nueva

set -e

DOTS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="$DOTS_DIR/config"

echo "🔵 KevDots Restore iniciando..."
echo "   Fuente: $DOTS_DIR"
echo ""

# ── Helpers ────────────────────────────────────────────────────────────────

install_if_missing() {
  local pkg="$1"
  if ! command -v "$pkg" &>/dev/null; then
    echo "  → Instalando $pkg..."
    brew install "$pkg"
  else
    echo "  ✓ $pkg ya instalado"
  fi
}

link() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$src" ]; then
    /bin/cp -rf "$src" "$dest"
    echo "  ✓ $dest"
  else
    echo "  ✗ $src (no encontrado en backup, omitido)"
  fi
}

# ── Homebrew ───────────────────────────────────────────────────────────────

echo "── Homebrew ───────────────────────────"
if ! command -v brew &>/dev/null; then
  echo "  → Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  ✓ Homebrew ya instalado"
fi

# ── Dependencias ───────────────────────────────────────────────────────────

echo ""
echo "── Dependencias ───────────────────────"
install_if_missing zsh
install_if_missing git
install_if_missing neovim
install_if_missing alacritty
install_if_missing zellij
install_if_missing starship
install_if_missing bat
install_if_missing lsd
install_if_missing fzf
install_if_missing fd
install_if_missing ripgrep
install_if_missing zoxide
install_if_missing lazygit
install_if_missing glow
install_if_missing node
install_if_missing go

# ── Oh My Zsh ─────────────────────────────────────────────────────────────

echo ""
echo "── Oh My Zsh ──────────────────────────"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  → Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "  ✓ Oh My Zsh ya instalado"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "  → Instalando zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "  → Instalando zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ── Nerd Fonts ─────────────────────────────────────────────────────────────

echo ""
echo "── Nerd Fonts ─────────────────────────"
if ! fc-list | grep -q "JetBrainsMono Nerd Font" 2>/dev/null; then
  echo "  → Instalando JetBrainsMono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font
else
  echo "  ✓ JetBrainsMono Nerd Font ya instalada"
fi

# ── Configs ────────────────────────────────────────────────────────────────

echo ""
echo "── Shell ──────────────────────────────"
link "$CONFIG_DIR/zsh/.zshrc"      ~/.zshrc
link "$CONFIG_DIR/zsh/.aliases"    ~/.aliases
mkdir -p ~/.config/zsh
link "$CONFIG_DIR/zsh/env.zsh"     ~/.config/zsh/env.zsh
link "$CONFIG_DIR/zsh/tools.zsh"   ~/.config/zsh/tools.zsh
link "$CONFIG_DIR/zsh/prompt.zsh"  ~/.config/zsh/prompt.zsh

echo ""
echo "── Terminal ───────────────────────────"
link "$CONFIG_DIR/alacritty"       ~/.config/alacritty
link "$CONFIG_DIR/zellij"          ~/.config/zellij
link "$CONFIG_DIR/starship.toml"   ~/.config/starship.toml

echo ""
echo "── Editor ─────────────────────────────"
link "$CONFIG_DIR/nvim"            ~/.config/nvim

echo ""
echo "── Herramientas ───────────────────────"
link "$CONFIG_DIR/bat"             ~/.config/bat
link "$CONFIG_DIR/lsd"             ~/.config/lsd
link "$CONFIG_DIR/git"             ~/.config/git

echo ""
echo "── Claude ─────────────────────────────"
mkdir -p ~/.claude
link "$CONFIG_DIR/claude/settings.json"  ~/.claude/settings.json
link "$CONFIG_DIR/claude/CLAUDE.md"      ~/.claude/CLAUDE.md
link "$CONFIG_DIR/claude/mcp.json"       ~/.claude/mcp.json
link "$CONFIG_DIR/claude/skills"         ~/.claude/skills
link "$CONFIG_DIR/claude/output-styles"  ~/.claude/output-styles

# ── Claude CLI ─────────────────────────────────────────────────────────────

echo ""
echo "── Claude CLI ─────────────────────────"
if ! command -v claude &>/dev/null; then
  echo "  → Instalando Claude CLI..."
  npm install -g @anthropic-ai/claude-code
else
  echo "  ✓ Claude CLI ya instalado"
fi

# ── Final ──────────────────────────────────────────────────────────────────

echo ""
echo "✅ Restore completado."
echo ""
echo "   Próximos pasos:"
echo "   1. source ~/.zshrc"
echo "   2. Abrir nvim — LazyVim instalará los plugins automáticamente"
echo "   3. clogin-personal / clogin-elsol / clogin-rocket para autenticar Claude"
echo ""
echo "   ¡Listo para trabajar! 🚀"
