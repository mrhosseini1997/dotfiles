#!/usr/bin/env bash
# ~/.claude/statusline.sh
# Claude Code status line — based on Oh My Zsh "candy" theme
# candy PROMPT: user@host [HH:MM:SS] [~/path] [git-branch] | model | ctx

input=$(cat)

# --- ANSI colors (matching candy theme) ---
bold_green='\033[1;32m'
blue='\033[0;34m'
bold_blue='\033[1;34m'
white='\033[0;37m'
green='\033[0;32m'
red='\033[0;31m'
reset='\033[0m'

# --- Model display name ---
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

# --- Current working directory (from Claude JSON, full path) ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
# Shorten $HOME to ~
display_dir="${cwd/#$HOME/~}"

# --- Git branch (skip optional locks to avoid blocking) ---
git_info=""
if [ -n "$cwd" ] && GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
           || GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    if ! GIT_OPTIONAL_LOCKS=0 git -C "$cwd" diff --quiet 2>/dev/null \
       || ! GIT_OPTIONAL_LOCKS=0 git -C "$cwd" diff --cached --quiet 2>/dev/null; then
      dirty=" ${red}*${green}"
    else
      dirty=""
    fi
    git_info="${green}[${branch}${dirty}]${reset}"
  fi
fi

# --- Context window usage ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')

# Format token counts in K for compactness
format_k() {
  local n=$1
  if [ -z "$n" ] || [ "$n" = "null" ]; then echo "?"; return; fi
  if [ "$n" -ge 1000 ] 2>/dev/null; then
    printf "%.0fk" "$(echo "scale=1; $n / 1000" | bc)"
  else
    echo "$n"
  fi
}

used_fmt=$(format_k "$used_tokens")
total_fmt=$(format_k "$total")

# Build context segment
if [ -n "$used_pct" ]; then
  ctx_segment=$(printf "%s/%s (%.0f%%)" "$used_fmt" "$total_fmt" "$used_pct")
else
  ctx_segment="no data yet"
fi

# --- Assemble status line ---
# Layout: [dir] [git] | model | ctx
printf "${white}[%s]${reset}" "$display_dir"

if [ -n "$git_info" ]; then
  printf " %b" "$git_info"
fi

printf " ${bold_blue}|${reset}"

[ -n "$model" ] && printf " %s ${bold_blue}|${reset}" "$model"

printf " ctx: %s\n" "$ctx_segment"
