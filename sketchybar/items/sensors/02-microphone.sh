#!/bin/bash

sketchybar --add item sensors.microphone right							\
           --set sensors.microphone script="$PLUGIN_DIR/sensors/microphone.sh"	\
                                   label.drawing=off                    \
                                   icon.padding_left=1                  
