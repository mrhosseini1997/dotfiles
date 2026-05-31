# tmux primer

A practical intro scoped to the keybindings in `tmux/tmux.conf`.

## What `C-a` means

`C-a` = hold `Ctrl` and press `a`. In tmux this is the **prefix key** — you press it first to tell tmux "the next key is a command, not text for the shell."

Default tmux uses `C-b`, but `C-a` is more ergonomic (closer to your left pinky, especially if you've remapped Caps Lock to Ctrl).

**Pattern:** every tmux binding is `prefix` + something. So `C-a |` means: press `Ctrl+a`, release, then press `|`.

## What "vi-mode" means

Two things in this config use vi keys:

1. **Copy mode** (selecting/copying text inside tmux): instead of arrow keys + mouse, you use `hjkl` to move, `v` to start selection, `y` to yank — like in Vim.
2. **Pane navigation**: `prefix h/j/k/l` jumps left/down/up/right between panes.

If you don't use Vim, this is still worth learning because the same keys work in lazygit, less, man pages, and many TUIs.

## Day-to-day tmux

**Start a session:**

```sh
tmux                    # new unnamed session
tmux new -s work        # new session named "work"
tmux ls                 # list sessions
tmux attach -t work     # reattach to "work"
```

**Detach (leave it running in background):** `C-a d` — your shell processes keep running, reattach anytime.

**Inside a session — the moves you'll actually use:**

| Want to... | Press |
|---|---|
| Split screen vertically | `C-a \|` |
| Split screen horizontally | `C-a -` |
| Jump between split panes | `C-a h/j/k/l` |
| Close a pane | type `exit` or `C-d` |
| New tab (window) | `C-a c` |
| Switch tabs | `C-a C-h` / `C-a C-l` |
| Zoom a pane fullscreen / unzoom | `C-a z` |
| Open lazygit popup | `C-a g` |
| Detach (leave running) | `C-a d` |
| Reload config after edits | `C-a r` |

**Copy text without mouse:**

1. `C-a Esc` → enter copy mode
2. `h j k l` to move cursor; `/text` to search forward
3. `v` to start selection, move cursor to extend it
4. `y` to copy to macOS clipboard
5. Paste anywhere with `Cmd+V`

**Typical workflow:**

```sh
tmux new -s myproject       # start session
# C-a |                       split: editor on left, shell on right
# nvim .          (in left pane)
# C-a l                       jump to right pane
# npm run dev     (in right pane)
# C-a d                       detach, close terminal
# ... later ...
tmux attach -t myproject    # everything still running
```

The mouse also works (`mouse on` is set) — click panes to focus, drag borders to resize, scroll to view history. Keys are faster once they're muscle memory but mouse is fine while you learn.
