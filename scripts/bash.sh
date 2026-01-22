pick_folder() {
    find ~/.dotFiles ~/work ~/hobby \
        \( -type d -path '*/.*' \
           -a ! -path '*/.dotFiles*' \
           -a ! -path '*/.archive' \) -prune \
        -o \( -type d -path '*/.archive/.*' \) -prune \
        -o -type d \
        -not -path '*/node_modules/*' \
        -not -path '*/.git/*' \
        -not -path '*/venv/*' \
        -print | fzf
}

fn() {
    folder="$(pick_folder)"
    [ -n "$folder" ] && nvim "$folder"
}


fd() {
    folder="$(pick_folder)"
    [ -n "$folder" ] && cd "$folder"
}

gc() {
    git commit -m "$*"
}

alias ga='git add .'
alias gs='lazygit'
alias gp='git push'


n() {
  if [ $# -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}

