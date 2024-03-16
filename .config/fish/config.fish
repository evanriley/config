#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
function __ssh_agent_is_started -d "check if ssh agent is already started"
	if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
		source $SSH_ENV > /dev/null
	end

	if test -z "$SSH_AGENT_PID"
		return 1
	end

	ssh-add -l > /dev/null 2>&1
	if test $status -eq 2
		return 1
	end
end

function __ssh_agent_start -d "start a new ssh agent"
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
  ssh-add
end

if not test -d $HOME/.ssh
    mkdir -p $HOME/.ssh
    chmod 0700 $HOME/.ssh
end

if test -d $HOME/.gnupg
    chmod 0700 $HOME/.gnupg
end

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end
set -g simple_ass_prompt_greeting ""
set -g fish_greeting
set -gx EDITOR nvim
set -gx PATH ~/bin ~/.local/bin $NPM_PACKAGES/bin ~/.roswell/bin ~/.yarn/bin ~/.cargo/bin ~/.config/emacs/bin /opt/homebrew/bin  /opt/homebrew/sbin ~/go/bin /opt/homebrew/opt/grep/libexec/gnubin '/Applications/Sublime Text.app/Contents/SharedSupport/bin' $PATH
set -gx GPG_TTY (tty)
## use asdf direnv plugin and hook into it
direnv hook fish | source

#source zoxide
zoxide init fish | source

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
alias du 'dust'

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

# Kanagawa Theme
set -l foreground DCD7BA normal
set -l selection 2D4F67 brcyan
set -l comment 727169 brblack
set -l red C34043 red
set -l orange FF9E64 brred
set -l yellow C0A36E yellow
set -l green 76946A green
set -l purple 957FB8 magenta
set -l cyan 7AA89F cyan
set -l pink D27E99 brmagenta

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment


starship init fish | source
rtx activate fish | source
