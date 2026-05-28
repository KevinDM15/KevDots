#!/bin/zsh
# KevDots — Interactive TUI Installer

set -e

DOTS_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── Check gum ─────────────────────────────────────────────────────────────

if ! command -v gum &>/dev/null; then
  echo "Installing gum (required for TUI)..."
  if command -v brew &>/dev/null; then
    brew install gum
  else
    curl -fsSL https://github.com/charmbracelet/gum/releases/latest/download/gum_Linux_arm64.tar.gz | tar -xz -C /usr/local/bin gum 2>/dev/null || \
    curl -fsSL https://github.com/charmbracelet/gum/releases/latest/download/gum_Linux_x86_64.tar.gz | tar -xz -C /usr/local/bin gum
  fi
fi

# ── Load modules ──────────────────────────────────────────────────────────

source "$DOTS_DIR/scripts/lib/log.sh"
source "$DOTS_DIR/scripts/modules/stow.sh"
source "$DOTS_DIR/scripts/modules/backup.sh"
source "$DOTS_DIR/scripts/modules/claude-accounts.sh"

# Detect OS and load the right deps script
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$DOTS_DIR/scripts/os/macos.sh"
  INSTALL_DEPS="install_macos_deps"
else
  source "$DOTS_DIR/scripts/os/linux.sh"
  INSTALL_DEPS="install_linux_deps"
fi

# ── Header ────────────────────────────────────────────────────────────────

clear
gum style \
  --foreground "$PURPLE" --border-foreground "$PURPLE" \
  --border double --align center --width 50 --padding "1 4" \
  "KevDots" "" "$(gum style --foreground "$GRAY" "by Kevin Diaz")"
echo ""

# ── Menu ──────────────────────────────────────────────────────────────────

ACTION=$(gum choose \
  --header "What do you want to do?" \
  --header.foreground "$PINK" \
  --selected.foreground "$PURPLE" \
  --cursor.foreground "$PURPLE" \
  "Full install (new machine)" \
  "Configs only (dependencies already installed)" \
  "Setup Claude accounts" \
  "Backup current config" \
  "Remove symlinks" \
  "Preview what will be installed" \
  "Exit")

case "$ACTION" in

"Full install (new machine)")
  gum confirm "This will install all dependencies and apply configs. Continue?" || exit 0
  $INSTALL_DEPS
  apply_stow
  echo ""
  gum style --foreground "$GREEN" --border normal --border-foreground "$GREEN" --padding "1 4" \
    "Installation complete." \
    "" \
    "Next steps:" \
    "  1. source ~/.zshrc" \
    "  2. Open nvim (plugins install automatically)" \
    "  3. claude auth login"
  ;;

"Configs only (dependencies already installed)")
  gum confirm "This will apply symlinks to your home directory. Continue?" || exit 0
  apply_stow
  echo ""
  gum style --foreground "$GREEN" --padding "1 2" "Done. Run: source ~/.zshrc"
  ;;

"Setup Claude accounts")
  setup_claude_accounts
  ;;

"Backup current config")
  gum confirm "Save current config to $DOTS_DIR/stow? Continue?" || exit 0
  run_backup
  echo ""
  if gum confirm "Commit and push to GitHub?"; then
    cd "$DOTS_DIR"
    git add .
    git commit -m "chore: backup $(date +%Y-%m-%d)"
    git push
    gum style --foreground "$GREEN" "Backup pushed to GitHub."
  else
    gum style --foreground "$GRAY" "Backup saved locally (no commit)."
  fi
  ;;

"Remove symlinks")
  gum confirm "This will remove all KevDots symlinks from your home directory. Continue?" || exit 0
  remove_stow
  ;;

"Preview what will be installed")
  section "Dependencies"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  neovim · zellij · alacritty · starship · bat · lsd"
    echo "  fzf · fd · ripgrep · zoxide · lazygit · glow · gum · stow"
    echo "  go · node · claude-cli · JetBrainsMono Nerd Font"
  else
    echo "  neovim · zellij · starship · bat · fzf · ripgrep"
    echo "  fd · zoxide · stow · node · claude-cli"
  fi
  section "Symlinks (via GNU Stow)"
  echo "  ~/.zshrc · ~/.aliases"
  echo "  ~/.config/zsh/ · ~/.config/alacritty/ · ~/.config/zellij/"
  echo "  ~/.config/nvim/ · ~/.config/starship.toml"
  echo "  ~/.config/bat/ · ~/.config/lsd/ · ~/.config/git/"
  echo "  ~/.claude/ (settings, CLAUDE.md, skills, output-styles)"
  echo ""
  gum style --foreground "$GRAY" "Press Enter to go back..."
  read
  exec "$0"
  ;;

"Exit")
  exit 0
  ;;
esac
