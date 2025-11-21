#!/bin/bash

# Add aerospace workspace change event
sketchybar --add event aerospace_workspace_change

# Function to add a workspace item
add_space_item() {
  local sid=$1
  local display_icon=$2
  
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
      associated_display=1 \
      icon="$display_icon" \
      icon.font="SF Pro:Semibold:16.0" \
      icon.color=$TEXT_COLOR \
      icon.padding_left=8 \
      icon.padding_right=4 \
      icon.y_offset=0 \
      label.font="sketchybar-app-font:Regular:16.0" \
      label.color=$TEXT_COLOR \
      label.padding_left=4 \
      label.padding_right=8 \
      label.y_offset=0 \
      background.color=$BG2 \
      background.corner_radius=5 \
      background.height=24 \
      background.drawing=on \
      update_freq=2 \
      script="$PLUGIN_DIR/aerospace.sh $sid" \
      click_script="aerospace workspace $sid"
}

# Create workspace items for 1-5
for sid in $(seq 1 5); do
  add_space_item $sid $sid
done

