#!/bin/zsh
# KevDots — macOS dependencies

source "$(dirname "$0")/../lib/log.sh"

install_macos_deps() {
  section "Homebrew"
  if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log_ok "Homebrew"
  else
    log_skip "Homebrew"
  fi

  section "CLI Tools"
  local tools=(neovim zellij starship bat lsd fzf fd ripgrep zoxide lazygit glow gum stow go node git)
  for tool in "${tools[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
      log_info "Installing $tool..."
      brew install "$tool" &>/dev/null && log_ok "$tool" || log_err "$tool"
    else
      log_skip "$tool"
    fi
  done

  section "Casks"
  local casks=(alacritty font-jetbrains-mono-nerd-font)
  for cask in "${casks[@]}"; do
    if ! brew list --cask "$cask" &>/dev/null; then
      log_info "Installing $cask..."
      brew install --cask "$cask" &>/dev/null && log_ok "$cask" || log_err "$cask"
    else
      log_skip "$cask"
    fi
  done

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
    log_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" &>/dev/null
    log_ok "zsh-autosuggestions"
  else
    log_skip "zsh-autosuggestions"
  fi

  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    log_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" &>/dev/null
    log_ok "zsh-syntax-highlighting"
  else
    log_skip "zsh-syntax-highlighting"
  fi

  section "Claude CLI"
  if ! command -v claude &>/dev/null; then
    log_info "Installing Claude CLI..."
    npm install -g @anthropic-ai/claude-code &>/dev/null && log_ok "Claude CLI" || log_err "Claude CLI"
  else
    log_skip "Claude CLI"
  fi
}
