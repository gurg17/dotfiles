#!/bin/bash

keyboard=(
	script="$PLUGIN_DIR/keyboard.sh"  
	label.drawing=off                   
	icon.padding_left=1              
	click_script="osascript -e 'tell application \"System Events\" to keystroke \" \" using {control down, option down}'" 
)

sketchybar --add item sensors.keyboard right											\
           --set sensors.keyboard "${keyboard[@]}"										\
		   --add event keyboard_change "AppleSelectedInputSourcesChangedNotification"	\
           --subscribe sensors.keyboard keyboard_change
