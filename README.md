# dotfiles

Personal configuration files, organized by tool. Each subdirectory is intended to be symlinked to its conventional location.

## Structure

| Path | Symlinked to | Notes |
|---|---|---|
| `nvim/` | `~/.config/nvim` | LazyVim-based Neovim config |

## Setup on a new machine

```sh
git clone https://github.com/<user>/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
```
