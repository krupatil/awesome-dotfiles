#!/bin/sh

LOCATION=$1
SETTING_FILE="~/.config/conky/settings"
MAIN_LUA_FILE="~/.config/conky/main.lua"
CONKY_CONF_FILE="~/.config/conky/conky.conf"

if [ \( "$LOCATION" != "home" \) -a \( "$LOCATION" != "office" \) ]; then
    echo "Usage: setup_conky.sh [office|home]"
fi

cp -rf "$SETTING_FILE"_"$LOCATION" $SETTING_FILE
cp -rf "$MAIN_LUA_FILE"_"$LOCATION" $MAIN_LUA_FILE
cp -rf "$CONKY_CONF_FILE"_"$LOCATION" $CONKY_CONF_FILE

