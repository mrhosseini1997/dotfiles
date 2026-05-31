# dotfiles

Personal configuration files, organized by tool. Each subdirectory is intended to be symlinked to its conventional location.

## Structure

| Path | Symlinked to | Notes |
|---|---|---|
| `nvim/` | `~/.config/nvim` | LazyVim-based Neovim config |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` | Ghostty terminal config |
| `zsh/zshrc` | `~/.zshrc` | Interactive shell config (Oh My Zsh) |
| `zsh/zprofile` | `~/.zprofile` | Login shell config (PATH, env vars) |

## Setup on a new machine

```sh
git clone https://github.com/<user>/dotfiles.git ~/dotfiles

# nvim
ln -s ~/dotfiles/nvim ~/.config/nvim

# ghostty
ln -s ~/dotfiles/ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# zsh
ln -s ~/dotfiles/zsh/zshrc    ~/.zshrc
ln -s ~/dotfiles/zsh/zprofile ~/.zprofile
```
