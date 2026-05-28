#!/bin/zsh
# KevDots — Interactive TUI Installer

set -e

DOTS_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$DOTS_DIR/config"

# ── Colors & Style ─────────────────────────────────────────────────────────

PURPLE="#9080f0"
PINK="#e080f0"
GREEN="#a0e0b0"
RED="#f07070"
GRAY="#d0c0e0"

header() {
  gum style \
    --foreground "$PURPLE" --border-foreground "$PURPLE" \
    --border double --align center --width 50 --padding "1 4" \
    "KevDots" "" "$(gum style --foreground "$GRAY" "by Kevin Diaz")"
}

log_ok()   { gum style --foreground "$GREEN" "  ✓ $1"; }
log_skip() { gum style --foreground "$GRAY"  "  · $1 (ya instalado)"; }
log_err()  { gum style --foreground "$RED"   "  ✗ $1"; }
log_info() { gum style --foreground "$PINK"  "  → $1"; }

section() {
  echo ""
  gum style --foreground "$PURPLE" --bold "── $1 ──────────────────────────"
}

# ── Helpers ────────────────────────────────────────────────────────────────

brew_install() {
  local pkg="$1"
  local label="${2:-$1}"
  if ! command -v "$pkg" &>/dev/null; then
    log_info "Instalando $label..."
    brew install "$pkg" &>/dev/null && log_ok "$label" || log_err "$label"
  else
    log_skip "$label"
  fi
}

brew_cask_install() {
  local cask="$1"
  local label="${2:-$1}"
  if ! brew list --cask "$cask" &>/dev/null; then
    log_info "Instalando $label..."
    brew install --cask "$cask" &>/dev/null && log_ok "$label" || log_err "$label"
  else
    log_skip "$label"
  fi
}

link_config() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$src" ]; then
    /bin/cp -rf "$src" "$dest"
    log_ok "$(basename "$dest")"
  else
    log_err "$(basename "$src") (no encontrado en backup)"
  fi
}

# ── Main ───────────────────────────────────────────────────────────────────

clear
header
echo ""

# Menú principal
ACTION=$(gum choose \
  --header "¿Qué querés hacer?" \
  --header.foreground "$PINK" \
  --selected.foreground "$PURPLE" \
  --cursor.foreground "$PURPLE" \
  "🚀  Instalación completa (nueva máquina)" \
  "📦  Solo configs (ya tengo las dependencias)" \
  "💾  Backup (guardar config actual)" \
  "🔍  Ver qué se instalará" \
  "❌  Salir")

case "$ACTION" in

# ── Instalación completa ───────────────────────────────────────────────────

"🚀  Instalación completa (nueva máquina)")
  gum confirm "Esto instalará Homebrew, dependencias y copiará todas las configs. ¿Continuar?" || exit 0

  section "Homebrew"
  if ! command -v brew &>/dev/null; then
    log_info "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log_ok "Homebrew"
  else
    log_skip "Homebrew"
  fi

  section "Dependencias CLI"
  brew_install nvim     "Neovim"
  brew_install zellij   "Zellij"
  brew_install starship "Starship"
  brew_install bat      "bat"
  brew_install lsd      "lsd"
  brew_install fzf      "fzf"
  brew_install fd       "fd"
  brew_install rg       "ripgrep"
  brew_install zoxide   "zoxide"
  brew_install lazygit  "lazygit"
  brew_install glow     "glow"
  brew_install gum      "gum"
  brew_install go       "Go"
  brew_install node     "Node.js"

  section "Terminal"
  brew_cask_install alacritty "Alacritty"
  brew_cask_install font-jetbrains-mono-nerd-font "JetBrainsMono Nerd Font"

  section "Oh My Zsh"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null
    log_ok "Oh My Zsh"
  else
    log_skip "Oh My Zsh"
  fi

  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    log_info "Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" &>/dev/null
    log_ok "zsh-autosuggestions"
  else
    log_skip "zsh-autosuggestions"
  fi

  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    log_info "Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" &>/dev/null
    log_ok "zsh-syntax-highlighting"
  else
    log_skip "zsh-syntax-highlighting"
  fi

  section "Claude CLI"
  if ! command -v claude &>/dev/null; then
    log_info "Instalando Claude CLI..."
    npm install -g @anthropic-ai/claude-code &>/dev/null && log_ok "Claude CLI" || log_err "Claude CLI"
  else
    log_skip "Claude CLI"
  fi

  section "Configuraciones"
  link_config "$CONFIG_DIR/zsh/.zshrc"       ~/.zshrc
  link_config "$CONFIG_DIR/zsh/.aliases"     ~/.aliases
  mkdir -p ~/.config/zsh
  link_config "$CONFIG_DIR/zsh/tools.zsh"    ~/.config/zsh/tools.zsh
  link_config "$CONFIG_DIR/zsh/prompt.zsh"   ~/.config/zsh/prompt.zsh
  link_config "$CONFIG_DIR/alacritty"        ~/.config/alacritty
  link_config "$CONFIG_DIR/zellij"           ~/.config/zellij
  link_config "$CONFIG_DIR/starship.toml"    ~/.config/starship.toml
  link_config "$CONFIG_DIR/nvim"             ~/.config/nvim
  link_config "$CONFIG_DIR/bat"              ~/.config/bat
  link_config "$CONFIG_DIR/lsd"              ~/.config/lsd
  link_config "$CONFIG_DIR/git"              ~/.config/git

  section "Claude"
  mkdir -p ~/.claude
  link_config "$CONFIG_DIR/claude/settings.json"  ~/.claude/settings.json
  link_config "$CONFIG_DIR/claude/CLAUDE.md"      ~/.claude/CLAUDE.md
  link_config "$CONFIG_DIR/claude/skills"         ~/.claude/skills
  link_config "$CONFIG_DIR/claude/output-styles"  ~/.claude/output-styles

  echo ""
  gum style --foreground "$GREEN" --border normal --border-foreground "$GREEN" --padding "1 4" \
    "✅ Instalación completa" \
    "" \
    "Próximos pasos:" \
    "  1. source ~/.zshrc" \
    "  2. Abrir nvim (instala plugins solo)" \
    "  3. claude auth login"
  ;;

# ── Solo configs ───────────────────────────────────────────────────────────

"📦  Solo configs (ya tengo las dependencias)")
  gum confirm "Se copiarán todas las configs sobre las existentes. ¿Continuár?" || exit 0

  section "Shell"
  link_config "$CONFIG_DIR/zsh/.zshrc"       ~/.zshrc
  link_config "$CONFIG_DIR/zsh/.aliases"     ~/.aliases
  mkdir -p ~/.config/zsh
  link_config "$CONFIG_DIR/zsh/tools.zsh"    ~/.config/zsh/tools.zsh
  link_config "$CONFIG_DIR/zsh/prompt.zsh"   ~/.config/zsh/prompt.zsh

  section "Terminal"
  link_config "$CONFIG_DIR/alacritty"        ~/.config/alacritty
  link_config "$CONFIG_DIR/zellij"           ~/.config/zellij
  link_config "$CONFIG_DIR/starship.toml"    ~/.config/starship.toml

  section "Editor"
  link_config "$CONFIG_DIR/nvim"             ~/.config/nvim

  section "Herramientas"
  link_config "$CONFIG_DIR/bat"              ~/.config/bat
  link_config "$CONFIG_DIR/lsd"              ~/.config/lsd
  link_config "$CONFIG_DIR/git"              ~/.config/git

  section "Claude"
  mkdir -p ~/.claude
  link_config "$CONFIG_DIR/claude/settings.json"  ~/.claude/settings.json
  link_config "$CONFIG_DIR/claude/CLAUDE.md"      ~/.claude/CLAUDE.md
  link_config "$CONFIG_DIR/claude/skills"         ~/.claude/skills
  link_config "$CONFIG_DIR/claude/output-styles"  ~/.claude/output-styles

  echo ""
  gum style --foreground "$GREEN" --padding "1 2" "✅ Configs copiadas. Ejecutá: source ~/.zshrc"
  ;;

# ── Backup ─────────────────────────────────────────────────────────────────

"💾  Backup (guardar config actual)")
  gum confirm "Se guardará tu config actual en $DOTS_DIR/config. ¿Continuar?" || exit 0
  "$DOTS_DIR/scripts/backup.sh"
  echo ""
  gum confirm "¿Commitear el backup a git?" && \
    cd "$DOTS_DIR" && git add . && git commit -m "chore: backup $(date +%Y-%m-%d)" && git push && \
    gum style --foreground "$GREEN" "✅ Backup pusheado a GitHub" || \
    gum style --foreground "$GRAY" "· Backup guardado localmente (sin commit)"
  ;;

# ── Preview ────────────────────────────────────────────────────────────────

"🔍  Ver qué se instalará")
  section "Herramientas"
  echo "  neovim · zellij · alacritty · starship · bat · lsd"
  echo "  fzf · fd · ripgrep · zoxide · lazygit · glow · gum"
  echo "  go · node · claude-cli"
  section "Configs"
  echo "  ~/.zshrc · ~/.aliases · ~/.config/zsh/"
  echo "  ~/.config/alacritty · ~/.config/zellij"
  echo "  ~/.config/nvim · ~/.config/starship.toml"
  echo "  ~/.config/bat · ~/.config/lsd · ~/.config/git"
  echo "  ~/.claude/ (settings, CLAUDE.md, skills, output-styles)"
  echo ""
  gum style --foreground "$GRAY" "Presioná Enter para volver..."
  read
  exec "$0"
  ;;

"❌  Salir")
  exit 0
  ;;
esac
