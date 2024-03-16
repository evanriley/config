if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH ~/bin $NPM_PACKAGES/bin ~/.cargo/bin ~/.emacs.d/bin $PATH
set -gx GPG_TTY (tty)

set -g fish_greeting

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'
