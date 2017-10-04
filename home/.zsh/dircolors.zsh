# Find dircolors executable
dircolors_exe=""
if [[ "$(uname -s)" == "Darwin" ]]; then
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls -FqN --color=auto' || alias ls='ls -GF'
    gdircolors &> /dev/null 2>&1 && dircolors_exe=gdircolors
else
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls -FqN --color=auto' || alias ls='ls -GF'
    dircolors &> /dev/null 2>&1 && dircolors_exe=dircolors
fi

# Find config path, preferring ~/.dir_colors
dircolors_path=""
[ -f /etc/DIR_COLORS ] && dircolors_path="/etc/DIR_COLORS"
[ -f $HOME/.dir_colors ] && dircolors_path="$HOME/.dir_colors"

# Apply dircolors
if [ -n "$dircolors_exe" ]; then
    if [ -n "$dircolors_path" ]; then
        eval $($dircolors_exe -b $dircolors_path)
    else
        eval $($dircolors_exe --print-database)
    fi
fi

