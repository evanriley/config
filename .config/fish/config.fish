if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

starship init fish | source
