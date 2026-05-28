#!/bin/zsh
# KevDots — Apply symlinks via GNU Stow

source "$(dirname "$0")/../lib/log.sh"

DOTS_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
STOW_DIR="$DOTS_DIR/stow"

apply_stow() {
  local packages=(zsh zsh-config alacritty zellij nvim starship bat lsd git claude)

  section "Applying symlinks (GNU Stow)"

  for pkg in "${packages[@]}"; do
    if [ -d "$STOW_DIR/$pkg" ]; then
      # Backup conflicting files before stowing
      stow --dir="$STOW_DIR" --target="$HOME" --no-folding "$pkg" 2>/dev/null && \
        log_ok "$pkg" || {
        log_info "Conflict in $pkg — backing up and retrying..."
        stow --dir="$STOW_DIR" --target="$HOME" --no-folding --adopt "$pkg" 2>/dev/null
        stow --dir="$STOW_DIR" --target="$HOME" --no-folding "$pkg" 2>/dev/null && \
          log_ok "$pkg (after backup)" || log_err "$pkg"
      }
    else
      log_skip "$pkg (not in stow/)"
    fi
  done
}

remove_stow() {
  local packages=(zsh zsh-config alacritty zellij nvim starship bat lsd git claude)

  section "Removing symlinks (GNU Stow)"
  for pkg in "${packages[@]}"; do
    if [ -d "$STOW_DIR/$pkg" ]; then
      stow --dir="$STOW_DIR" --target="$HOME" -D "$pkg" 2>/dev/null && \
        log_ok "removed $pkg" || log_skip "$pkg (not linked)"
    fi
  done
}
