set -g simple_ass_prompt_greeting ""
set -g fish_greeting
set -gx EDITOR nvim
set -gx PATH ~/bin ~/.local/bin $NPM_PACKAGES/bin ~/.roswell/bin ~/.yarn/bin ~/.cargo/bin ~/.emacs.d/bin /opt/homebrew/bin  /opt/homebrew/sbin ~/go/bin /opt/homebrew/opt/grep/libexec/gnubin $PATH
set -gx GPG_TTY (tty)
## Source asdf
source ~/.asdf/asdf.fish
. ~/.asdf/plugins/java/set-java-home.fish
## use asdf direnv plugin and hook into it
direnv hook fish | source

## Secretive.app Secret Agent.
set -x SSH_AUTH_SOCK /Users/evan/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# Aliases
# Use this to manage dotfiles
alias config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias vim 'nvim'

## get rid of command not found
alias cd.. 'cd ..'

## a quick way to get out of current directory ##
alias .. 'cd ..'
alias ... 'cd ../../../'
alias .... 'cd ../../../../'
alias ..... 'cd ../../../../'
alias .4 'cd ../../../../'
alias .5 'cd ../../../../..'

alias gac 'git add . && git commit -a -m '
alias gl 'git pull --prune'
alias glog "git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp 'git push origin HEAD'
alias gd 'git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias gc 'git commit'
alias gca 'git commit -a'
alias gco 'git checkout'
alias gcb 'git copy-branch-name'
alias gb 'git branch'
alias gs 'git status -sb'
alias ge 'git-edit-new'

##wtf is my ip address...##
alias myip "curl http://ipecho.net/plain; echo"

## more util commands
alias ls 'exa'
alias l 'exa -l'
alias ll 'exa -l | less'
alias la 'exa -la'
alias lg 'exa --git'
alias cat 'bat'

# use pinentry-mac instead of pinentry on  mac
if test (uname) = "Darwin"
  alias pinentry 'pinentry-mac'
end


if test (uname) = "Darwin"
  # the -CC argument is take advantage of iTerm2s tmux features
 function tma # tmux attach to either last session or if given an argument connect to named session
    if [ -z "$argv" ];
      tmux -CC attach
    else
      tmux -CC attach -t $argv
    end
 end

 function tmn # tmux new either create the 'main' session or new one named by argument
    if [ -z "$argv" ];
      tmux -CC new -A -s main
    else
      tmux -CC new -A -s $argv
    end
 end
end
fish_add_path /Users/evan/.spicetify
