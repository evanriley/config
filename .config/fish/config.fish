set -g simple_ass_prompt_greeting ""
set -g fish_greeting
set -gx EDITOR nvim
set -gx PATH ~/bin ~/.local/bin $NPM_PACKAGES/bin ~/.roswell/bin ~/.yarn/bin ~/.cargo/bin ~/.config/emacs/bin /opt/homebrew/bin  /opt/homebrew/sbin ~/go/bin /opt/homebrew/opt/grep/libexec/gnubin '/Applications/Sublime Text.app/Contents/SharedSupport/bin' $PATH
set -gx GPG_TTY (tty)
## Source asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish
## use asdf direnv plugin and hook into it
direnv hook fish | source

#source zoxide
zoxide init fish | source

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

##wtf is my ip address...##
alias myip "curl http://ipecho.net/plain; echo"

## more util commands
alias ls 'exa'
alias l 'exa -l'
alias ll 'exa -l | less'
alias la 'exa -la'
alias lg 'exa --git'
alias cat 'bat'

# use pinentry-mac instead of pinentry on macos
if test (uname) = "Darwin"
  alias pinentry 'pinentry-mac'
end

# iTerm2 (on MacOS) has a nice tmux intergration. This commands just make it easier to use.
if test (uname) = "Darwin"
  # the -CC argument is take advantage of iTerm2's tmux features
 function tma # tmux attach to either the last session or if given an argument connect to named session
    if [ -z "$argv" ];
      tmux -CC attach
    else
      tmux -CC attach -t $argv
    end
 end

 function tmn # tmux new either create the 'main' session or new one named by the given argument
    if [ -z "$argv" ];
      tmux -CC new -A -s main
    else
      tmux -CC new -A -s $argv
    end
 end
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/evan/.ghcup/bin $PATH # ghcup-env


starship init fish | source
