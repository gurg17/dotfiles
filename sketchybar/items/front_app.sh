#!/bin/bash

sketchybar --add item front_app left \
  --set front_app \
    icon.font="sketchybar-app-font:Regular:16.0" \
    icon.padding_left=8 \
    icon.padding_right=4 \
    icon.y_offset=0 \
    label.font="SF Pro:Semibold:16.0" \
    label.padding_left=4 \
    label.padding_right=8 \
    label.y_offset=0 \
    background.color=$BG2 \
    background.corner_radius=5 \
    background.height=24 \
    update_freq=1 \
    script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched

