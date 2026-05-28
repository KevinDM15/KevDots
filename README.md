<p align="center">
  <img src="./LOGO_KEVDOTS.png" alt="KevDots" width="400" />
</p>

# KevDots

Personal dotfiles for macOS — Alacritty + Zellij + LazyVim + Starship + Zsh.

## Stack

| Tool | Purpose |
|------|---------|
| [Alacritty](https://alacritty.org) | Terminal emulator |
| [Zellij](https://zellij.dev) | Terminal multiplexer (tabs, panels) |
| [Neovim](https://neovim.io) + [LazyVim](https://lazyvim.org) | Editor |
| [Starship](https://starship.rs) | Shell prompt |
| [Zsh](https://zsh.org) + Oh My Zsh | Shell |
| [Claude Code](https://claude.ai/code) | AI assistant in terminal |

## Quick Install

```sh
git clone https://github.com/KevinDM15/KevDots.git ~/KevDots
~/KevDots/install.sh
```

The installer is an interactive TUI with four options:

- **Full install** — installs all dependencies via Homebrew and copies configs
- **Configs only** — copies configs assuming dependencies are already installed
- **Backup** — saves your current config to this repo and pushes to GitHub
- **Preview** — shows what will be installed before committing

## LSP Support

Configured for: TypeScript, JavaScript, Python, Go, Dart/Flutter, Lua.

Installed via LazyVim extras — servers are managed automatically by Mason.

## Structure

```
KevDots/
├── config/
│   ├── alacritty/     # Terminal config (purple/black theme, blur, transparency)
│   ├── zellij/        # Multiplexer config + cheatsheet
│   ├── nvim/          # LazyVim plugins and settings
│   ├── zsh/           # Shell modules (env, tools, prompt)
│   ├── claude/        # Claude Code settings, skills, output styles
│   ├── bat/           # bat (cat replacement) config
│   ├── lsd/           # lsd (ls replacement) config
│   └── git/           # Git config
├── scripts/
│   ├── backup.sh      # Copy current config into this repo
│   └── restore.sh     # Restore config to a new machine
├── install.sh         # Interactive TUI installer
└── .gitignore         # Excludes tokens and credentials
```

## Keybindings

See `config/zellij/CHEATSHEET.md` for a full reference. Open it from the terminal with:

```sh
cheat
```

## Notes

- `config/zsh/env.zsh` is excluded from git — it contains API keys and tokens.
- `config/claude/mcp.json` is excluded from git — it references secrets via env vars.
- Claude accounts are managed via `CLAUDE_CONFIG_DIR` — see aliases in `.aliases`.
