# Oh-my-zsh {{{ 1
# Path and theme {{{ 2
# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_THEME="gallifrey"
# }}} 2
# Basic {{{ 2   
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd-mm-yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
DISABLE_CORRECTION="true"
# }}} 2
# Plugins {{{ 2   
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=( \
    cp \
    debian \
    git-extras git-prompt git-remote-branch git gitignore \
    git-flow-avh git-flow  \
    jira \
    mvn \
    mongo mongodb \
    node npm nvm \
    pyenv \
    pylint \
    spring \
    ssh-agent \
    sudo \
    thefuck \
    tmux tmuxinator )
# Setup {{{ 3   
# Tmux
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"
# }}} 3
# }}} 2
source $ZSH/oh-my-zsh.sh
# }}} 1
# User configuration {{{ 1
unsetopt correct_all

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Gruvbox
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# The fuck
eval $(thefuck --alias)

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Global Alias {{{ 2
# Mutt
alias mutt='cd $HOME/Downloads/;/usr/bin/mutt;cd -'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Idea
alias idea="bash ${HOME}/Documents/tools/idea/idea-IU-182.4505.22/bin/idea.sh"
# }}} 2
# }}} 1
# Tools configuration {{{ 1
# Tmux {{{ 2
export TERM="screen-256color"
[[ $TMUX = "" ]] && export TERM="xterm-256color"

alias tmuxKillDetached='tmux list-sessions | grep -E -v '\(attached\)$' | while IFS='\n' read line; do tmux kill-session -t "${line%%:*}"; done'
# }}} 2
# Mycli {{{ 2
# Fix less output
export LESS="-RXF"
# }}} 2
# Java {{{ 2
export JDK_7_HOME='/opt/java/64/jdk1.7.0_79/'
export JDK_8_HOME='/opt/java/64/jdk1.8.0_101/'
export JDK_9_HOME='/opt/java/64/jdk-9.0.1'
export JAVA_7_HOME=$JDK_7_HOME
export JAVA_8_HOME=$JDK_8_HOME
export JAVA_9_HOME=$JDK_9_HOME
export JAVA_HOME=$JDK_8_HOME
export PATH=$JAVA_HOME/bin:$PATH
# }}} 2
# Vim {{{ 2
# Vim mode
set -o vi
export KEYTIMEOUT=1
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^q' backward-word
bindkey '^x' forward-word
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# Vim fast
alias vimfast='vim -u NONE -N'
# }}} 2
# Fancy ctrl z {{{ 2
fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
else
    zle push-input
    zle clear-screen
fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# }}} 2
# FZF {{{ 2
alias ffzf='find * | fzf'

set -o vi
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# }}} 2
# Maven {{{ 2
export NVM_DIR="$HOME/.nvm"

# Speed up java starting
export MAVEN_OPTS='-XX:+TieredCompilation -XX:TieredStopAtLevel=1'
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

alias mvn='mvn -T 1C'

# }}} 2
# Undistract-me {{{ 2
# commands to ignore
cmdignore=(htop less man nvim ssh tail tmux top vim vi

# set gt 0 to enable GNU units for time results
gnuunits=0

# end and compare timer, notify-send if needed
function notifyosd-precmd() {
	retval=$?
    if [[ ${cmdignore[(r)$cmd_basename]} == $cmd_basename ]]; then
        return
    else
        if [ ! -z "$cmd" ]; then
            cmd_end=`date +%s`
            ((cmd_secs=$cmd_end - $cmd_start))
        fi
        if [ $retval -gt 0 ]; then
			cmdstat="with warning"
			sndstat="/usr/share/sounds/LinuxMint/stereo/dialog-error.ogg"
			urgency="normal"
		else
            cmdstat="successfully"
			sndstat="/usr/share/sounds/LinuxMint/stereo/dialog-warning.ogg"
			urgency="normal"
        fi
        if [ ! -z "$cmd" -a $cmd_secs -gt 10 ]; then
			if [ $gnuunits -gt 0 ]; then
				cmd_time=$(units "$cmd_secs seconds" "centuries;years;months;weeks;days;hours;minutes;seconds" | \
						sed -e 's/\ +/\,/g' -e s'/\t//')
			else
				cmd_time="$cmd_secs seconds"
			fi
            if [ ! -z $SSH_TTY ] ; then
                notify-send -i utilities-terminal \
                        -t 2000 \
						-u $urgency \
                        "$cmd_basename on `hostname` completed $cmdstat" "\"$cmd\" took $cmd_time"; \
						play -q $sndstat
            else
                notify-send -i utilities-terminal \
                        -t 2000 \
						-u $urgency \
                        "$cmd_basename completed $cmdstat" "\"$cmd\" took $cmd_time"; \
						play -q $sndstat
            fi
        fi
        unset cmd
    fi
}

# make sure this plays nicely with any existing precmd
precmd_functions+=( notifyosd-precmd )

# get command name and start the timer
function notifyosd-preexec() {
    cmd=$1
    cmd_basename=${${cmd:s/sudo //}[(ws: :)1]} 
    cmd_start=`date +%s`
}

# make sure this plays nicely with any existing preexec
preexec_functions+=( notifyosd-preexec )
# }}} 2
# }}} 1
# Actito {{{ 1
export ACTITO_HOME=~/Actito/
export ACTITO_USER=houtn

# ${HOME}/RnD/scriptRND/yacli
if [ -f ${HOME}/RnD/scriptRND/yacli/config/alias.config ]; then
    source ${HOME}/RnD/scriptRND/yacli/config/alias.config
fi
# }}} 1
