# Directory for my customizations
ZSH=$HOME/.zsh
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

# Paths to add to PATH. I should be able to put these in .zshenv, but every
# distro seems intent on breaking this with their own settings that clobber
# PATH in the system-wide zprofile.
path=(
    # Local binaries
    "$HOME/local/bin"
    "$HOME/local/usr/bin"
    "$HOME/.local/bin"
    "$HOME/.scripts"
    "$HOME/Library/python/3.4/bin"

    # Ruby
    "$HOME/.gem/ruby/1.8/bin"
    "$HOME/.gem/ruby/1.9.1/bin"
    "$HOME/.gem/ruby/2.0.0/bin"
    "$HOME/.gem/ruby/2.1.0/bin"
    "$HOME/.gem/ruby/2.2.0/bin"
    "$HOME/.gem/ruby/2.3.0/bin"
    "$HOME/.rvm/bin"

    # Android SDK binaries
    "$HOME/androidsdk/platform-tools"
    "$HOME/androidsdk/tools"

    # Microchip compiler binaries
    "$HOME/local/microchip/xc8/bin"
    "$HOME/local/microchip/xc16/bin"
    "$HOME/local/microchip/xc32/bin"

    # Homebrew binaries
    "/usr/local/bin"
    "/usr/local/sbin"

    # Cargo binaries
    #"$HOME/.cargo/bin"

    # pyenv binaries
    "$HOME/.pyenv/bin"

    # VSCode binaries
    '/Applications/Visual Studio Code.app/Contents/Resources/app/bin'

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

# If Dropbox folder is in expected locations export env var
[[ -d "$HOME/Dropbox" ]] && export DROPBOX='~/Dropbox'

# Source local tokens/keys if present
[[ -f "$HOME/.zsh/tokens.zsh" ]] && source "$HOME/.zsh/tokens.zsh"

# Enable pyenv, if it is installed
if whence -p pyenv >/dev/null; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(pyenv init -)"
fi

# Enable rvm, if it is installed
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

# Point Racer at the Rust src distribution
command -v rustc >/dev/null 2>&1 && \
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Options
setopt autocontinue
setopt correct
setopt notify
setopt noautopushd

# Enable SSH agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Source my "plugin" scripts
# Aliases
source $HOME/.scripts/alias

# Extra functions/env
source $HOME/.scripts/my_env

source "$ZSH/dircolors.zsh"
source "$ZSH/homesick.zsh"

# Clean up paths, removing duplicates and non-existant directories
source $HOME/.zsh/prune-paths.zsh

# Fix https://github.com/robbyrussell/oh-my-zsh/issues/1398
zstyle ':completion:*' matcher-list 'r:|=*' '+ r:|[._-]=* l:|=*'


export TERM="xterm-256color"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. ~/.local/lib/python3.4/site-packages/powerline/bindings/zsh/powerline.zsh
