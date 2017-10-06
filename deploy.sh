 ### Get os name via uname ###
 _myos="$(uname)"

install_symlinks()
{
    ln -s $DOT_FILES_REPO/home/.Xresources ~/.Xresources
    ln -s $DOT_FILES_REPO/home/.bash-completion/ ~/.bash-completion
    ln -s $DOT_FILES_REPO/home/.bash_logout ~/.bash_logout
    ln -s $DOT_FILES_REPO/home/.bash_profile ~/.bash_profile
    ln -s $DOT_FILES_REPO/home/.bashrc ~/.bashrc
    ln -s $DOT_FILES_REPO/home/.config/ ~/.config
    ln -s $DOT_FILES_REPO/home/.dir_colors ~/.dir_colors
    ln -s $DOT_FILES_REPO/home/.fluxbox/ ~/.fluxbox 
    ln -s $DOT_FILES_REPO/home/.gitconfig ~/.gitconfig 
    ln -s $DOT_FILES_REPO/home/.gitignore_global ~/.gitignore_global
    ln -s $DOT_FILES_REPO/home/.vimrc ~/.vimrc
    ln -s $DOT_FILES_REPO/home/.ideavimrc ~/.ideavimrc
    ln -s $DOT_FILES_REPO/home/.viminfo ~/.viminfo
    ln -s $DOT_FILES_REPO/home/.inputrc ~/.inputrc 
    ln -s $DOT_FILES_REPO/home/.scripts/ ~/.scripts 
    ln -s $DOT_FILES_REPO/home/.tmux.conf ~/.tmux.conf
    ln -s $DOT_FILES_REPO/home/.vim/ ~/.vim
    ln -s $DOT_FILES_REPO/home/.vim_undo/ ~/.vim_undo
    ln -s $DOT_FILES_REPO/home/.xinitrc ~/.xinitrc 
    ln -s $DOT_FILES_REPO/home/.zsh/ ~/.zsh
    ln -s $DOT_FILES_REPO/home/.zshrc ~/.zshrc
    ln -s $DOT_FILES_REPO/home/.ssh ~/.ssh
}

install_osx_packages()
{
    brew install colordiff
}

install_linux_packages()
{
    sudo apt-get install colordiff
}

install_packages()
{
    ### install packages as per os using
    case $_myos in
       Linux)
           install_linux_packages ;;
       Darwin)
           install_osx_packages ;;
       *)
           echo "Unsupported operating system."
           exit -1;;
    esac
}

install()
{
    install_packages
    install_symlinks
}

remove_symlinks()
{
    rm -rf ~/.Xresources
    rm -rf ~/.bash-completion
    rm -rf ~/.bash_logout
    rm -rf ~/.bash_profile
    rm -rf ~/.bashrc
    rm -rf ~/.bashrc.swp
    rm -rf ~/.config
    rm -rf ~/.dir_colors
    rm -rf ~/.fluxbox
    rm -rf ~/.gitconfig
    rm -rf ~/.gitignore_global
    rm -rf ~/.vimrc
    rm -rf ~/.ideavimrc
    rm -rf ~/.viminfo
    rm -rf ~/.inputrc
    rm -rf ~/.scripts
    rm -rf ~/.tmux.conf
    rm -rf ~/.vim
    rm -rf ~/.vim_undo
    rm -rf ~/.xinitrc
    rm -rf ~/.zsh
    rm -rf ~/.zshrc
    rm -rf ~/.ssh
}

remove_osx_packages()
{
    brew remove colordiff
}

remove_linux_packages()
{
    sudo apt-get remove colordiff
}

remove_packages()
{
    ### uninstall packages as per os using
    case $_myos in
       Linux)
           remove_linux_packages ;;
       Darwin)
           remove_osx_packages ;;
       *)
           echo "Unsupported operating system."
           exit -1;;
    esac
}

remove()
{
    remove_packages
    remove_symlinks
}

usage()
{
    echo "Usage: ./deploy.sh <install|remove> <path for dotfiles repo>"
    exit
}

# Entry point for script
if [ $# -lt 2 ]; then
    usage
fi

CMD="$1"
DOT_FILES_REPO="$2"

case $CMD in
    "install") install;;
    "remove") remove;;
    (*)
        usage;;
esac
