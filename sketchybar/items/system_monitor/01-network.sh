#!/bin/bash

source "$CONFIG_DIR/colors.sh"

network=(
	icon=􀙇
	icon.font="SF Pro:Semibold:16.0"
	icon.color="$ICON_COLOR"
	icon.padding_left=4
	icon.padding_right=8
	label.drawing=off
	background.border_width=0
	popup.background.color="$BG2"
	popup.background.border_width=2
	popup.background.corner_radius=5
	popup.background.border_color="$ICON_COLOR"
	update_freq=3
	script="$PLUGIN_DIR/network/network_hover.sh"
)

sketchybar --add item system_monitor.network right \
	--set system_monitor.network "${network[@]}" \
	--subscribe system_monitor.network mouse.entered mouse.exited \
	\
	--add item system_monitor.network.ip popup.system_monitor.network \
	--set system_monitor.network.ip \
		icon=􀵴 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="Loading..." \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=5 \
		script="$PLUGIN_DIR/network/ip.sh" \
	\
	--add item system_monitor.network.router popup.system_monitor.network \
	--set system_monitor.network.router \
		icon=􀌘 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="Loading..." \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=10 \
		script="$PLUGIN_DIR/network/router.sh" \
	\
	--add item system_monitor.network.vpn popup.system_monitor.network \
	--set system_monitor.network.vpn \
		icon=􀞚 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="Loading..." \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=5 \
		script="$PLUGIN_DIR/network/vpn.sh" \
	\
	--add item system_monitor.network.down popup.system_monitor.network \
	--set system_monitor.network.down \
		icon=􀄩 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="Loading..." \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=2 \
		script="$PLUGIN_DIR/network/down.sh" \
	\
	--add item system_monitor.network.up popup.system_monitor.network \
	--set system_monitor.network.up \
		icon=􀄨 \
		icon.font="SF Pro:Semibold:14.0" \
		icon.color="$ICON_COLOR" \
		icon.padding_right=8 \
		icon.y_offset=0 \
		label="Loading..." \
		label.font="SF Pro:Semibold:13.0" \
		label.y_offset=0 \
		background.padding_left=5 \
		background.padding_right=5 \
		update_freq=2 \
		script="$PLUGIN_DIR/network/up.sh"
