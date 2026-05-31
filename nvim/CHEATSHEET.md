# Neovim Cheatsheet (LazyVim)

You came from VSCode. This is what you actually need for the first month.

## Modes — the One Big Idea

Vim has modes. The mode determines what your keys do.

| Mode    | Enter from Normal       | What it's for                       |
|---------|-------------------------|-------------------------------------|
| Normal  | `<Esc>` (always)        | Movement, deletion, the default     |
| Insert  | `i` (or `a`, `o`, `O`)  | Typing text                         |
| Visual  | `v` (or `V`, `<C-v>`)   | Selecting text                      |
| Command | `:`                     | Running ex-commands like `:w`, `:q` |

**Rule of thumb:** when in doubt, press `<Esc>` until you're back in Normal mode.

## Survival commands

- `:w` — save
- `:q` — quit (fails if unsaved)
- `:wq` — save and quit
- `:q!` — quit, discard changes
- `u` — undo (Normal mode)
- `<C-r>` — redo (Normal mode)
- `:e <path>` — open file

## The leader key is your friend

The **leader key is `<Space>`**. Press it and *wait* — a menu appears showing every keybind by category (`f` = find, `g` = git, `c` = code, …). This is your escape hatch when you forget a shortcut.

## Top keybinds (daily use)

| Keybind           | What it does           | VSCode equivalent           |
|-------------------|------------------------|-----------------------------|
| `<Space><Space>`  | Find file in project   | Cmd+P                       |
| `<Space>/`        | Grep across project    | Cmd+Shift+F                 |
| `<Space>e`        | Toggle file tree       | Sidebar                     |
| `<Space>gg`       | Open lazygit           | Source Control panel        |
| `<Space>cf`       | Format buffer          | Format Document             |
| `<Space>ca`       | Code action            | Quick Fix (Cmd+.)           |
| `<Space>cr`       | Rename symbol          | F2                          |
| `<Space>cd`       | Show diagnostic detail | (hover on red squiggle)     |
| `<Space>ss`       | Symbol outline         | Cmd+Shift+O                 |
| `gd`              | Go to definition       | F12                         |
| `gr`              | Find references        | Shift+F12                   |
| `K`               | Hover docs             | Hover                       |
| `]d` / `[d`       | Next / prev diagnostic | F8 / Shift+F8               |
| `<C-/>`           | Toggle terminal        | Ctrl+`                      |

## Movement (Normal mode)

You almost never use arrow keys. The real motions:

- `h j k l` — left, down, up, right
- `w` / `b` — next / previous word
- `0` / `$` — start / end of line
- `gg` / `G` — top / bottom of file
- `<C-d>` / `<C-u>` — half page down / up
- `{` / `}` — previous / next blank line
- `%` — jump to matching bracket
- `<C-o>` / `<C-i>` — jump back / forward through cursor history (after `gd`, this returns you)

## Editing without leaving Normal mode

- `dd` — delete (cut) line
- `yy` — yank (copy) line
- `p` — paste
- `dw` — delete word
- `ciw` — change inner word (delete it + enter Insert mode)
- `ci"` — change inside quotes
- `ci(` / `ci{` / `ci[` — change inside brackets
- `.` — repeat last change

## Search and replace

- `/pattern` — search forward
- `?pattern` — search backward
- `n` / `N` — next / previous match
- `*` — search for word under cursor
- `:%s/old/new/g` — replace all in file
- `:%s/old/new/gc` — replace all, confirming each

## Windows / splits

- `<C-w>s` — horizontal split
- `<C-w>v` — vertical split
- `<C-w>h/j/k/l` — move between splits
- `<C-w>q` — close current split
- `<C-w>=` — equalize split sizes

## Buffers (open files)

- `<Space>bb` — buffer switcher
- `<Space>bd` — delete buffer (closes file)
- `<S-h>` / `<S-l>` — previous / next buffer (LazyVim default)

## Plugin / LSP management

- `:Lazy` — plugin manager UI (update, sync, profile)
- `:LazyExtras` — toggle bundled feature sets (languages, etc.)
- `:Mason` — install/uninstall LSPs, formatters, linters
- `:checkhealth` — diagnose problems
- `:checkhealth vim.lsp` — LSP-specific health (replaces the old `:LspInfo`)

## When you're stuck

- `:Tutor` — built-in 30-min Vim tutorial. **Do this once.**
- `<Space>` + wait — menu of every binding
- `:help <topic>` — built-in docs (e.g. `:help motions`)
- `<Esc>` `<Esc>` `<Esc>` — back to Normal mode if you're disoriented
