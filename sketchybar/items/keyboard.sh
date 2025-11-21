#!/bin/bash

source "$CONFIG_DIR/colors.sh"

keyboard=(
    icon.padding_right=6
    label.drawing=off
    script="$PLUGIN_DIR/keyboard.sh"
    click_script="osascript -e 'tell application \"System Events\" to keystroke \" \" using {control down, option down}'"
)

sketchybar --add item keyboard right \
           --set keyboard "${keyboard[@]}" \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe keyboard keyboard_change
