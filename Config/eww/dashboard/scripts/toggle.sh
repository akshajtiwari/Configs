#!/bin/bash

CONFIG_DIR="$HOME/.config/eww/dashboard"

# Kill any stuck processes first
if pgrep -f "eww.*dashboard" >/dev/null; then
  if eww --config "$CONFIG_DIR" windows 2>/dev/null | grep -q "\*dashboard"; then
    eww --config "$CONFIG_DIR" close dashboard
    exit 0
  fi
fi

# Open dashboard
eww --config "$CONFIG_DIR" open dashboard
