#
# ~/.bashrc
#

# If not running interactively, don't do anything
#
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

parse_git_branch() {
  git branch 2>/dev/null | sed -n 's/^\* \(.*\)/ (\1)/p'
}

PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0;33m\]$(parse_git_branch)\[\e[0m\]\$ '

HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='ls:cd:pwd:exit:clear'
shopt -s histappend
PROMPT_COMMAND='history -a'

shopt -s autocd
shopt -s cdspell
shopt -s globstar
shopt -s checkwinsize

alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'

alias vl='verilator --binary -j 0 -Wall'
alias wave='gtkwave'
vcd() { gtkwave "$1" >/dev/null 2>&1 & }

# ─── bat ────────────────────────────────────────────────
export BAT_THEME="Nord"
alias cat='bat --paging=never'
alias catp='bat -p --paging=never' # sin números ni marco
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# ─── eza ────────────────────────────────────────────────
alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons'
alias ltr='eza -lah --icons --sort=modified'

# ─── fzf ────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 45% --layout=reverse --border=rounded
  --color=bg+:#2e3440,fg+:#eceff4,hl:#88c0d0,hl+:#8fbcbb
  --color=info:#ebcb8b,prompt:#81a1c1,pointer:#b48ead
  --bind=ctrl-/:toggle-preview'

# Ctrl+T — buscar ficheros, con preview
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :300 {}'"

# Ctrl+R — historial, con el comando completo en el preview
export FZF_CTRL_R_OPTS="--no-preview --wrap"

# Alt+C — saltar a un directorio
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=1 --icons {}'"

eval "$(fzf --bash)"

ff() {
  local f
  f=$(fd --type f --hidden --exclude .git "${1:-}" |
    fzf --preview 'bat -n --color=always --line-range :300 {}')
  [ -z "$f" ] && return
  echo "$f"
  command -v wl-copy >/dev/null && printf '%s' "$f" | wl-copy
}

fn() {
  local f
  f=$(fd --type f --hidden --exclude .git "${1:-}" |
    fzf --preview 'bat -n --color=always --line-range :300 {}')
  [ -n "$f" ] && nvim "$f"
}

# ─── zoxide (va al final) ───────────────────────────────
eval "$(zoxide init bash)"
export PATH="$HOME/.local/bin:$PATH"
