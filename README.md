# dotfiles

Personal configuration files, organized by tool. Each subdirectory is intended to be symlinked to its conventional location.

## Structure

| Path | Symlinked to | Notes |
|---|---|---|
| `nvim/` | `~/.config/nvim` | LazyVim-based Neovim config |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` | Ghostty terminal config + tmux-style keybindings |
| `tmux/tmux.conf` | `~/.config/tmux/tmux.conf` | tmux config (prefix `C-a`, vi-mode, lazygit popup) |
| `zsh/zshrc` | `~/.zshrc` | Interactive shell config (Oh My Zsh, fzf, zoxide) |
| `zsh/zprofile` | `~/.zprofile` | Login shell config (PATH, env vars) |
| `claude/settings.json` | `~/.claude/settings.json` | Claude Code permissions & defaults |

## Prerequisites

```sh
# Core tools
brew install neovim tmux fzf zoxide fd lazygit

# Shell
brew install zsh-autosuggestions zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Optional: font used by Ghostty
brew install --cask font-jetbrains-mono
```

## Setup on a new machine

```sh
git clone https://github.com/<user>/dotfiles.git ~/dotfiles

# nvim
ln -s ~/dotfiles/nvim ~/.config/nvim

# ghostty
ln -s ~/dotfiles/ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# tmux
mkdir -p ~/.config/tmux
ln -s ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf

# zsh
ln -s ~/dotfiles/zsh/zshrc    ~/.zshrc
ln -s ~/dotfiles/zsh/zprofile ~/.zprofile

# claude
mkdir -p ~/.claude
ln -s ~/dotfiles/claude/settings.json ~/.claude/settings.json
```

## Usage cheatsheet

### Ghostty — tmux-style keybindings (prefix `cmd+s`)

| Chord | Action |
|---|---|
| `cmd+s` then `\` | Split right |
| `cmd+s` then `-` | Split down |
| `cmd+s` then `h/j/k/l` | Focus pane left/down/up/right |
| `cmd+s` then `z` | Toggle pane zoom |
| `cmd+s` then `e` | Equalize splits |
| `cmd+s` then `c` | New tab |
| `cmd+s` then `1`–`9` | Jump to tab N |
| `cmd+s` then `shift+h` / `shift+l` | Previous / next tab |
| `cmd+s` then `,` / `.` | Move tab left / right |

### tmux (prefix `C-a`)

| Key | Action |
|---|---|
| `C-a |` | Split horizontal (keep CWD) |
| `C-a -` | Split vertical (keep CWD) |
| `C-a h/j/k/l` | Focus pane |
| `C-a H/J/K/L` | Resize pane (repeatable) |
| `C-a C-h` / `C-a C-l` | Previous / next window |
| `C-a c` | New window (keep CWD) |
| `C-a g` | lazygit popup |
| `C-a r` | Reload config |
| `C-a Esc` | Enter copy-mode (vi keys; `v` select, `y` yank to clipboard) |

### zsh extras

- **fzf**: `Ctrl-T` (file search), `Ctrl-R` (history), `Alt-C` (cd into dir)
- **zoxide**: `z <fragment>` jumps to most-used matching dir
- History is shared live across sessions; duplicates collapse

### Claude Code

`~/.claude/settings.json` ships a permission policy:
- **Auto-allow** read-only Bash (`ls`, `git status`, `gh *`, `jq`, `kubectl get`, …), `Read`, `Glob`, `Grep`, `WebFetch`, `WebSearch`
- **Deny** reads from `.env*`, `~/.ssh`, `~/.aws`, and dangerous `rm -rf` patterns
- **Ask** before `git commit/push`, `gh pr merge`, `docker push`, `terraform apply`, `kubectl delete`, etc.

Adjust per project via `.claude/settings.local.json` in the project root.
