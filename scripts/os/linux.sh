#!/bin/zsh
# KevDots — Linux dependencies

source "$(dirname "$0")/../lib/log.sh"

install_linux_deps() {
  section "Detecting package manager"

  if command -v apt &>/dev/null; then
    PKG="apt"
    INSTALL="sudo apt install -y"
    sudo apt update -qq
  elif command -v pacman &>/dev/null; then
    PKG="pacman"
    INSTALL="sudo pacman -S --noconfirm"
  elif command -v dnf &>/dev/null; then
    PKG="dnf"
    INSTALL="sudo dnf install -y"
  else
    log_err "No supported package manager found (apt, pacman, dnf)"
    exit 1
  fi
  log_ok "Using $PKG"

  section "CLI Tools"
  local tools=(git zsh neovim stow fzf ripgrep fd-find zoxide bat)
  for tool in "${tools[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
      log_info "Installing $tool..."
      $INSTALL "$tool" &>/dev/null && log_ok "$tool" || log_err "$tool"
    else
      log_skip "$tool"
    fi
  done

  section "Starship"
  if ! command -v starship &>/dev/null; then
    log_info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes &>/dev/null && log_ok "Starship" || log_err "Starship"
  else
    log_skip "Starship"
  fi

  section "Oh My Zsh"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null
    log_ok "Oh My Zsh"
  else
    log_skip "Oh My Zsh"
  fi

  local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" &>/dev/null
    log_ok "zsh-autosuggestions"
  else
    log_skip "zsh-autosuggestions"
  fi

  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" &>/dev/null
    log_ok "zsh-syntax-highlighting"
  else
    log_skip "zsh-syntax-highlighting"
  fi

  section "Claude CLI"
  if ! command -v claude &>/dev/null; then
    if command -v npm &>/dev/null; then
      log_info "Installing Claude CLI..."
      npm install -g @anthropic-ai/claude-code &>/dev/null && log_ok "Claude CLI" || log_err "Claude CLI"
    else
      log_err "npm not found — install Node.js first, then run: npm install -g @anthropic-ai/claude-code"
    fi
  else
    log_skip "Claude CLI"
  fi
}
