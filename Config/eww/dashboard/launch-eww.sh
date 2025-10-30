#!/bin/bash

# Disable GTK theme for EWW
export GTK_THEME=''
export GTK2_RC_FILES=''

CONFIG_DIR="$HOME/.config/eww/dashboard"

# Kill existing
pkill -9 eww
sleep 1

# Start with no theme
eww --config "$CONFIG_DIR" daemon &
sleep 2

# Open dashboard
eww --config "$CONFIG_DIR" open dashboard
