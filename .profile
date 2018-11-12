# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -e /usr/share/terminfo/x/xterm-256color  ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

export TERM='screen-256color'

export JDK_8u60_HOME='/opt/java/64/jdk1.8.0_101/'
export JDK_8_HOME='/opt/java/64/jdk1.8.0_101/'

# Idea shortcut
alias idea='bash ~/Documents/tools/idea-IU-162.1628.40/bin/idea.sh'

export PATH=$PATH:/home/houtn/RnD/scriptRND
export ACTITO_HOME=~/Actito/

export PATH="$HOME/.cargo/bin:$PATH"

xmodmap -e "remove lock = Caps_Lock"
