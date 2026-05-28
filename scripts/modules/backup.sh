#!/bin/zsh
# KevDots — Backup current config into stow packages

source "$(dirname "$0")/../lib/log.sh"

DOTS_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
STOW_DIR="$DOTS_DIR/stow"

run_backup() {
  section "Shell"
  /bin/cp ~/.zshrc                   "$STOW_DIR/zsh/.zshrc"               && log_ok ".zshrc"
  /bin/cp ~/.aliases                 "$STOW_DIR/zsh/.aliases"             && log_ok ".aliases"
  /bin/cp ~/.config/zsh/env.zsh     "$STOW_DIR/zsh-config/.config/zsh/env.zsh"   && log_ok "env.zsh"
  /bin/cp ~/.config/zsh/tools.zsh   "$STOW_DIR/zsh-config/.config/zsh/tools.zsh" && log_ok "tools.zsh"
  /bin/cp ~/.config/zsh/prompt.zsh  "$STOW_DIR/zsh-config/.config/zsh/prompt.zsh" && log_ok "prompt.zsh"

  section "Terminal"
  /bin/cp -r ~/.config/alacritty    "$STOW_DIR/alacritty/.config/alacritty" && log_ok "alacritty"
  /bin/cp -r ~/.config/zellij       "$STOW_DIR/zellij/.config/zellij"       && log_ok "zellij"
  /bin/cp    ~/.config/starship.toml "$STOW_DIR/starship/.config/starship.toml" && log_ok "starship"

  section "Editor"
  /bin/cp -r ~/.config/nvim          "$STOW_DIR/nvim/.config/nvim"          && log_ok "nvim"

  section "Tools"
  /bin/cp -r ~/.config/bat           "$STOW_DIR/bat/.config/bat"            && log_ok "bat"
  /bin/cp -r ~/.config/lsd           "$STOW_DIR/lsd/.config/lsd"            && log_ok "lsd"
  /bin/cp -r ~/.config/git           "$STOW_DIR/git/.config/git"            && log_ok "git"

  section "Claude"
  /bin/cp    ~/.claude/settings.json "$STOW_DIR/claude/.claude/settings.json"    && log_ok "settings.json"
  /bin/cp    ~/.claude/CLAUDE.md     "$STOW_DIR/claude/.claude/CLAUDE.md"        && log_ok "CLAUDE.md"
  /bin/cp -r ~/.claude/skills        "$STOW_DIR/claude/.claude/skills"           && log_ok "skills"
  /bin/cp -r ~/.claude/output-styles "$STOW_DIR/claude/.claude/output-styles"   && log_ok "output-styles"
}
