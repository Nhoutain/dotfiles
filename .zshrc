
# Oh-my-zsh {{{ 1
# Path and theme {{{ 2
# Path to your oh-my-zsh installation.
source $HOME/dotfiles/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle compleat
antigen bundle cp
antigen bundle debian
antigen bundle fzf
antigen bundle git-extras 
antigen bundle git-prompt 
antigen bundle git-remote-branch 
antigen bundle git gitignore 
antigen bundle github
antigen bundle helm
antigen bundle jira
antigen bundle kubectl
antigen bundle mvn
antigen bundle mongo 
antigen bundle mongodb
antigen bundle node 
antigen bundle npm 
antigen bundle nvm
antigen bundle pip
antigen bundle pyenv
antigen bundle pylint
antigen bundle spring
antigen bundle ssh-agent
antigen bundle sudo
antigen bundle thefuck
antigen bundle tmux 
antigen bundle tmuxinator
antigen bundle web-search

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search 
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle junegunn/fzf

antigen bundle johanhaleby/kubetail

# Load the theme.
antigen theme gallifrey

# Tell Antigen that you're done.
antigen apply
# }}} 2
# Basic {{{ 2   
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable the escape of curl
DISABLE_MAGIC_FUNCTIONS="true"

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
# Bundle config {{{ 2
# configure your keybindings here... just 2 lines of code!
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Tmux
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"

# Auto suggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
bindkey -M viins '^o' autosuggest-execute
bindkey -M viins '^ ' autosuggest-accept

# }}} 2
# }}} 1
# User configuration {{{ 1
unsetopt correct_all

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH:${HOME}/.local/bin/:${HOME}/dotfiles/bin:${HOME}/.cargo/bin"
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
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
if command -v exa > /dev/null; then
    alias ls='exa'
    alias la='exa -a'
    alias ll='exa -l'
    alias lll='exa -la'
    alias lla='exa -la'
else
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

# Exa
# }}} 2
# }}} 1
# Tools configuration {{{ 1
# Tmux {{{ 2
export TERM="screen-256color"
[[ $TMUX = "" ]] && export TERM="xterm-256color"

alias tmuxKillDetached='tmux list-sessions | grep -E -v '\(attached\)$' | while IFS='\n' read line; do tmux kill-session -t "${line%%:*}"; done'
TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
# }}} 2
# Mycli {{{ 2
# Fix less output
export LESS="-RXF"
# }}} 2
# Java {{{ 2
#cli
export JDK_8_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JDK_11_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export JAVA_8_HOME=$JDK_8_HOME
export JAVA_11_HOME=$JDK_11_HOME
export JAVA_HOME=$JDK_11_HOME
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
bindkey '^[[Z' reverse-menu-complete


# Vim fast
alias vimfast='vim -u NONE -N'
alias vif='vimfast'
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
source ~/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/fzf/fzf.plugin.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# }}} 2
# Note {{{ 2
alias note='terminal_velocity'
# }}} 2
# Maven {{{ 2
export NVM_DIR="$HOME/.nvm"

# Speed up java starting
export MAVEN_OPTS='-XX:+TieredCompilation -XX:TieredStopAtLevel=1'
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# }}} 2
# Undistract-me {{{ 2
# Based on https://gist.github.com/ihashacks/4576452
# commands to ignore
cmdignore=(fg git htop idea less man nvim ranger ssh tail tmux top vim vi)
setopt BASH_REMATCH

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
			urgency="normal"
		else
            cmdstat="successfully"
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
            else
                notify-send -i utilities-terminal \
                        -t 2000 \
						-u $urgency \
                        "$cmd_basename completed $cmdstat" "\"$cmd\" took $cmd_time"; \
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
    cmd_baseclean=${${cmd:s/sudo //}[(ws: :)1]} 

    cmd_alias=$(alias ${cmd_baseclean})
    if [ -z "$cmd_alias" ]; then
        cmd_basename=${cmd_baseclean}
    else 
        regex="(.*)=[']?([^']*)[']?"
        if [[ ${cmd_alias} =~ ${regex} ]]; then 
            toReplace=${BASH_REMATCH[2]}
            replacer=${BASH_REMATCH[3]}
            cmd_basename=${${cmd_baseclean/${toReplace}/${replacer}}[(ws: :)1]}
        else 
            cmd_basename=${cmd_baseclean}
        fi
    fi 
    cmd_start=`date +%s`
}

# make sure this plays nicely with any existing preexec
preexec_functions+=( notifyosd-preexec )
# }}} 2
# }}} 1
# EMAsphere {{{ 1
## For this fucking sencha
export OPENSSL_CONF=/etc/ssl/
source ~/.ema_aliases
# }}} 1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
