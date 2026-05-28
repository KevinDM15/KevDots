# === ZSH Configuration ===
# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  macos
  brew
)

source $ZSH/oh-my-zsh.sh

# === Load Configuration Modules ===
# Environment variables and tool paths
[ -f ~/.config/zsh/env.zsh ] && source ~/.config/zsh/env.zsh

# Development tools (zoxide, fzf, thefuck, etc.)
[ -f ~/.config/zsh/tools.zsh ] && source ~/.config/zsh/tools.zsh

# Prompt configuration
[ -f ~/.config/zsh/prompt.zsh ] && source ~/.config/zsh/prompt.zsh

# Custom aliases
[ -f ~/.aliases ] && source ~/.aliases
[ -s "/Users/kevindm14/.jabba/jabba.sh" ] && source "/Users/kevindm14/.jabba/jabba.sh"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/kevindm14/.lmstudio/bin"
# End of LM Studio CLI section


# Added by Antigravity IDE
export PATH="/Users/kevindm14/.antigravity-ide/antigravity-ide/bin:$PATH"

alias cheat='zellij action new-pane --floating --name "cheatsheet" --width "55%" --height "95%" -- /bin/zsh -c "/opt/homebrew/bin/glow -p ~/.config/zellij/CHEATSHEET.md"'

eval "$(starship init zsh)"
