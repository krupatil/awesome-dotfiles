# Directory for my customizations
ZSH=$HOME/.zsh
ENABLE_OLD_CONFIG=false

if $ENABLE_OLD_CONFIG; then
ADOTDIR=$HOME/.antigen

# Download and install antigen if it doesn't exist
if [ ! -f "$ADOTDIR/antigen/antigen.zsh" ]; then
    echo "zsh antigen not installed - cloning..."
    mkdir -p "$ADOTDIR"
    git clone https://github.com/zsh-users/antigen "$ADOTDIR/antigen"
fi

# Install antigen plugins
source "$ADOTDIR/antigen/antigen.zsh"
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
    # oh-my-zsh plugins
    cargo
    colored-man-pages
    command-not-found
    docker
    history
    rust
    ssh-agent
    z
    supercrabtree/k

   # github plugins
    lukechilds/zsh-nvm
    radhermit/gentoo-zsh-completions
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
EOBUNDLES
antigen apply
source "$ZSH/themes/krupatil.zsh-theme"
fi

# Paths to add to PATH. I should be able to put these in .zshenv, but every
# distro seems intent on breaking this with their own settings that clobber
# PATH in the system-wide zprofile.
path=(
    # Local binaries
    "$HOME/local/bin"
    "$HOME/local/usr/bin"
    "$HOME/.local/bin"
    "$HOME/.scripts"
    "$HOME/Library/python/3.5/bin"

    # Ruby
    "$HOME/.rbenv/bin"
    "$HOME/.gem/ruby/1.8/bin"
    "$HOME/.gem/ruby/1.9.1/bin"
    "$HOME/.gem/ruby/2.0.0/bin"
    "$HOME/.gem/ruby/2.1.0/bin"
    "$HOME/.gem/ruby/2.2.0/bin"
    "$HOME/.gem/ruby/2.3.0/bin"
    "$HOME/.rvm/bin"

    # Homebrew binaries
    "/usr/local/bin"
    "/usr/local/sbin"

    # Cargo binaries
    #"$HOME/.cargo/bin"

    # pyenv binaries
    "$HOME/.pyenv/bin"

    # Include system paths
    $path
)
export path

# The only sane editor option
export EDITOR='vim'

# Use UTF-8
export LANG=en_US.UTF-8

# Use local libraries if available
[[ -d "$HOME/local/lib" ]] && export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"

# Options
setopt autocontinue
setopt correct
setopt notify
setopt noautopushd

# Enable SSH agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Extra functions/env
source $HOME/.scripts/my_env

# Start tmux session
source $HOME/.scripts/terminal-start-tmux

#source ~/.zsh/dircolors.zsh

# Clean up paths, removing duplicates and non-existant directories
source $HOME/.zsh/prune-paths.zsh

# Fix https://github.com/robbyrussell/oh-my-zsh/issues/1398
zstyle ':completion:*' matcher-list 'r:|=*' '+ r:|[._-]=* l:|=*'

# for VIM and TMUX
if [ "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/krupatil/.oh-my-zsh"

# Select Powerline Theme
ZSH_THEME="powerlevel9k/powerlevel9k"
source ~/.zsh/powerlevel.zsh

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
plugins=(git git-extras gem bundler ruby rvm rails sudo sublime colorize history history-substring-search last-working-dir compleat zsh-completions zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting zsh-syntax-highlighting-filetypes warhol)
autoload -U compinit && compinit

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
source ~/.zsh/archey.zsh
source ~/.zsh/history.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/man-pages.zsh
source $(dirname $(gem which colorls))/tab_complete.sh
source $ZSH/oh-my-zsh.sh

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. ~/.local/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh
