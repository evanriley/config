set -gx EDITOR nvim
set -gx PATH ~/bin ~/.local/bin $NPM_PACKAGES/bin ~/.roswell/bin ~/.yarn/bin ~/.cargo/bin ~/.emacs.d/bin /opt/homebrew/bin ~/go/bin /opt/homebrew/opt/grep/libexec/gnubin $PATH
set -gx GPG_TTY (tty)

set -g fish_greeting

# Aliases
# Use this to manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias vim='nvim'

## get rid of command not found
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias wget='wget -c'

##honestly this isn't something that should be used...##
alias gac='git add . && git commit -a -m '
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb'
alias ge='git-edit-new'

##wtf is my ip address...##
alias myip="curl http://ipecho.net/plain; echo"

## more util commands
alias ls='exa'
alias l='exa -l'
alias ll='exa -l | less'
alias la='exa -la'
alias lg='exa --git'
alias cat='bat'

if test (uname) = "Darwin"
 alias tmn 'tmux -CC new -A -s main'
 alias tma 'tmux -CC attach'
 function tmxn
  tmux -u -CC new -A -s $argv
 end
end

# tidy
alias tidy=/opt/homebrew/bin/tidy

# pyenv
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# frum
frum init | source

# fnm
fnm env | source

starship init fish | source
