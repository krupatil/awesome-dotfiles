# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

### Get os name via uname ###
_myos="$(uname)"

if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# The only sane editor option
export EDITOR=vim

# If Dropbox folder is in expected locations export env var
if [[ -d ~/Dropbox ]]
then
    export DROPBOX='~/Dropbox'
fi

# Workaround for Windows boxes with msys console
case ${OS} in
    Windows*)
        export TERM=msys
esac

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Change the window title of X terminals 
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
        ;;
esac

# Aliases
source $HOME/.scripts/alias

# Stylize PS1
norm='\[\033[00;00m\]'
grn='\[\033[01;32m\]'
blu='\[\033[01;34m\]'
red='\[\033[01;31m\]'
yel='\[\033[00;33m\]'
if [[ ${EUID} == 0 ]] ; then
    usercolor="$red"
else
    usercolor="$grn"
fi

if [[ -f ~/.bash-completion/git-completion.bash && -f ~/.bash-completion/git-prompt.sh ]]
then
    source ~/.bash-completion/git-completion.bash
    source ~/.bash-completion/git-prompt.sh
    PROMPT_COMMAND="__git_ps1 '$usercolor\u@\h $blu\w$yel' '$blu \$ $norm'"
else
    PS1="$usercolor\u@\h $blu\w \$ $norm"
fi
unset norm grn blue red yel usercolor

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
use_color=false
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi
fi
unset use_color safe_term match_lhs

# Enable bash-completion if it exists
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
# Misc completions
source ~/.bash-completion/gibo-completion.bash
source ~/.bash-completion/cargo-completion.bash
source ~/.bash-completion/homesick-completion.bash
source ~/.bash-completion/tmux-completion.bash

# Display message if homesick files more than a week old
now=`date +%s`
fetch_head=~/.homesick/repos/dotfiles/.git/FETCH_HEAD
last_fetch=`stat -c %Y $fetch_head 2>/dev/null || echo $now`
if [[ $((now - last_fetch)) -gt 604800 ]]
then
    echo "Your homesick repo is over a week old."
    echo "Please do an update at your earliest convenience."
fi

# Make command history only keep unique commands
export HISTCONTROL="ignoreboth:erasedups"

# Make history size more reasonable
export HISTSIZE="100000"
export HISTFILESIZE=""

# Append to history file, don't overwrite it
shopt -s histappend

# Adds colon separated items to "var" if they exist. If multiples items are
# specified, they will be added in the order provided.
add_if_exists() {
    local var_name=$1
    shift
    for (( i = ${#@}; i > 0; i-- ))
    {
        local item=`echo ${!i}`
        if [ -d ${item} ]; then
            if [ -z "${!var_name}" ]; then
                export "${var_name}=${item}"
            else
                export "${var_name}=${item}:${!var_name}"
            fi
        fi
    }
}

# MacPorts paths
add_if_exists PATH \
    "/opt/local/bin" \
    "/opt/local/sbin" \
    "/opt/local/libexec/gnubin"

# Local binaries
add_if_exists PATH \
    "$HOME/local/bin" \
    "$HOME/.local/bin" \
    "$HOME/.scripts"
add_if_exists LD_LIBRARY_PATH \
    "$HOME/local/lib"

# Ruby gem binaries
add_if_exists PATH \
    "$HOME/.gem/ruby/1.8/bin" \
    "$HOME/.gem/ruby/1.9.1/bin" \
    "$HOME/.gem/ruby/2.0.0/bin"

# Android SDK binaries
add_if_exists PATH \
    "$HOME/androidsdk/platform-tools" \
    "$HOME/androidsdk/tools"

# Microchip compiler binaries
add_if_exists PATH \
    "$HOME/local/microchip/xc8/bin" \
    "$HOME/local/microchip/xc16/bin" \
    "$HOME/local/microchip/xc32/bin"

# Cargo binaries
add_if_exists PATH \
    "$HOME/.cargo/bin"

# PyEnv
add_if_exists PATH \
    "$HOME/.pyenv/bin"
if which pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Go path
add_if_exists PATH \
    "/usr/local/go/bin"

add_if_exists GOROOT \
    "/usr/local/go"

unset add_if_exists
