#!/bin/zsh
# KevDots — Shared logging utilities

PURPLE="#9080f0"
PINK="#e080f0"
GREEN="#a0e0b0"
RED="#f07070"
GRAY="#d0c0e0"

log_ok()   { gum style --foreground "$GREEN" "  ✓ $1"; }
log_skip() { gum style --foreground "$GRAY"  "  · $1 (already installed)"; }
log_err()  { gum style --foreground "$RED"   "  ✗ $1"; }
log_info() { gum style --foreground "$PINK"  "  → $1"; }

section() {
  echo ""
  gum style --foreground "$PURPLE" --bold "── $1 ──────────────────────────"
}
