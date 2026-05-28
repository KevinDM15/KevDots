# === Development Tools Configuration ===
# Zoxide, FZF, TheFuck, etc.

# === Zoxide (Smart Directory Navigation) ===
eval "$(zoxide init zsh)"

# === FZF (Fuzzy Finder) ===
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS="
  --color=bg:#1e1e2e,bg+:#313244,spinner:#f5c2e7,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5c2e7
  --color=marker:#a6e3a1,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --preview-window=right:50%
  --preview='bat {} 2>/dev/null || cat {}'
  --reverse
  --multi
"

# === TheFuck (Command Correction) ===
eval $(thefuck --alias)
