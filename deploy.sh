#!/bin/sh

### Export build env
. ./build_env

execute()
{
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

    ### Run common scripts
    run-parts --exit-on-error --arg=$CMD $COMMON_SCRIPT_DIR
}

usage()
{
    echo "Usage: ./deploy.sh <install|remove>"
    exit
}

# Entry point for script
if [ $# -lt 1 ]; then
    usage
fi

CMD="$1"

case $CMD in
    "install"|"remove")
        execute;;
    (*)
        usage;;
esac
