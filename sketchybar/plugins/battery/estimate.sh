#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

BATT_INFO=$(pmset -g batt)
PERCENTAGE=$(echo "$BATT_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATT_INFO" | grep 'AC Power')

# Get time remaining, filtering out unwanted text
TIME_REMAINING=$(echo "$BATT_INFO" | grep -o "[0-9]\+:[0-9]\+" | head -1)

if [ -z "$PERCENTAGE" ]; then
  sketchybar --set "$NAME" label="N/A" label.color=$TEXT_COLOR
  exit 0
fi

# Set icon based on charging status
if [ -n "$CHARGING" ]; then
  ICON="􀫯"
else
  ICON="􁠸"
fi

# Build label with percentage
LABEL="${PERCENTAGE}%"

# Add time estimate if available and valid
if [ -n "$TIME_REMAINING" ] && [ "$TIME_REMAINING" != "0:00" ]; then
  if [ -n "$CHARGING" ]; then
    LABEL="$LABEL • Charging ($TIME_REMAINING)"
  else
    LABEL="$LABEL • $TIME_REMAINING remaining"
  fi
elif [ -n "$CHARGING" ] && [ "$PERCENTAGE" -ge 95 ]; then
  LABEL="$LABEL • Fully charged"
fi

# Color based on percentage (matching battery.sh logic)
if [ -n "$CHARGING" ]; then
  COLOR=$BLUE
elif [ "$PERCENTAGE" -ge 90 ]; then
  COLOR=$ICON_COLOR
elif [ "$PERCENTAGE" -ge 60 ]; then
  COLOR=$GREEN
elif [ "$PERCENTAGE" -ge 30 ]; then
  COLOR=$YELLOW
elif [ "$PERCENTAGE" -ge 10 ]; then
  COLOR=$ORANGE
else
  COLOR=$RED
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color=$COLOR \
  label="$LABEL"
