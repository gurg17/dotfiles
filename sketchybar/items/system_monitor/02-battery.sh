#!/bin/bash

source "$CONFIG_DIR/colors.sh"

battery=(
	icon.font="SF Pro:Semibold:16.0"
	icon.padding_left=8
	icon.padding_right=4
	label.drawing=off
	update_freq=120
	popup.background.border_width=2
	popup.background.corner_radius=5
	popup.background.border_color="$ICON_COLOR"
	popup.background.color="$BG2"
	script="$PLUGIN_DIR/battery/battery.sh"
	click_script="sketchybar --set system_monitor.battery popup.drawing=toggle; sketchybar --set system_monitor.network popup.drawing=off; sketchybar --set resources popup.drawing=off"
)

sketchybar --add item system_monitor.battery right \
	--set system_monitor.battery "${battery[@]}" \
	--subscribe system_monitor.battery system_woke power_source_change mouse.entered mouse.exited \
	\
	--add item system_monitor.battery.estimate popup.system_monitor.battery \
	--set system_monitor.battery.estimate \
		icon=􀐫 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="Loading..." \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=30 \
		script="$PLUGIN_DIR/battery/estimate.sh" \
	\
	--add item system_monitor.battery.cpu popup.system_monitor.battery \
	--set system_monitor.battery.cpu \
		icon=􀧓 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="N/A" \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=2 \
		script="$PLUGIN_DIR/battery/cpu.sh" \
	\
	--add item system_monitor.battery.ram popup.system_monitor.battery \
	--set system_monitor.battery.ram \
		icon=􀧖 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="N/A" \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=2 \
		script="$PLUGIN_DIR/battery/ram.sh" \
	\
	--add item system_monitor.battery.disk popup.system_monitor.battery \
	--set system_monitor.battery.disk \
		icon=􀨪 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="N/A" \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=10 \
		script="$PLUGIN_DIR/battery/disk.sh" \
	\
	--add item system_monitor.battery.temp popup.system_monitor.battery \
	--set system_monitor.battery.temp \
		icon=􀇬 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_left=8 \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="N/A" \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=5 \
		script="$PLUGIN_DIR/battery/temp.sh"
