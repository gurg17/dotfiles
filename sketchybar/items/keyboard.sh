#!/bin/bash

source "$CONFIG_DIR/colors.sh"

keyboard=(
    icon.padding_left=8
    icon.padding_right=9
    label.drawing=off
    background.color=$BG2
    background.corner_radius=5
    background.height=24
    script="$PLUGIN_DIR/sensors/keyboard.sh"
    click_script="osascript -e 'tell application \"System Events\" to keystroke \" \" using {control down, option down}'"
)

sketchybar --add item keyboard right \
           --set keyboard "${keyboard[@]}" \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe keyboard keyboard_change
