### Get os name via uname ###
OS="$(uname)"

execute()
{
    ### Run common scripts
    run-parts --exit-on-error --arg=$CMD $COMMON_SCRIPT_DIR;;

    ### Run scripts as per os
    case $OS in
       Linux)
           run-parts --exit-on-error --arg=$CMD $LINUX_SCRIPT_DIR;;
       Darwin)
           run-parts --exit-on-error --arg=$CMD $OSX_SCRIPT_DIR;;
       *)
           echo "Unsupported operating system."
           exit -1;;
    esac
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
COMMON_SCRIPT_DIR=$DOT_FILES_REPO/home/.scripts/pc-setup/common
LINUX_SCRIPT_DIR=$DOT_FILES_REPO/home/.scripts/pc-setup/linux
OSX_SCRIPT_DIR=$DOT_FILES_REPO/home/.scripts/pc-setup/osx

case $CMD in
    "install"|"remove")
        execute;;
    (*)
        usage;;
esac
