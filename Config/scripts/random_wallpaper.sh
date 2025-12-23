#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Pick a random wallpaper
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( \
  -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \
\) | shuf -n 1)

# Exit if none found
[ -z "$RANDOM_WALLPAPER" ] && exit 1

# Set wallpaper with swww
swww img "$RANDOM_WALLPAPER" \
  --transition-fps 255 \
  --transition-type outer \
  --transition-duration 0.8

# Generate colors using pywal (terminal colors auto-update)
wal -i "$RANDOM_WALLPAPER" -n

# Reload Waybar (SIGUSR2 is preferred for style reload)
pkill -SIGUSR2 waybar || waybar &

