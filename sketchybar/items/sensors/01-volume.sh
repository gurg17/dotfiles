#!/bin/bash

sketchybar --add item sensors.volume right                      \
           --set sensors.volume script="$PLUGIN_DIR/sensors/volume.sh"	\
                               label.drawing=off				\
                               icon.padding_left=8	            \
           --subscribe sensors.volume volume_change
