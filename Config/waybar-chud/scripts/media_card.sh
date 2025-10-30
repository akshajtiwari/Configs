#!/bin/bash

# This script outputs JSON for Waybar custom module for media player status + controls
# Requires: playerctl, jq (optional but recommended)

player=$(playerctl -l 2>/dev/null | head -n1)

if [[ -z "$player" ]]; then
  # No media player found
  echo "{\"text\":\"No media playing\", \"class\":\"stopped\"}"
  exit 0
fi

# Get metadata and status
status=$(playerctl --player="$player" status 2>/dev/null)
artist=$(playerctl --player="$player" metadata artist 2>/dev/null)
title=$(playerctl --player="$player" metadata title 2>/dev/null)
album=$(playerctl --player="$player" metadata album 2>/dev/null)

# Fallback for empty artist/title
if [[ -z "$artist" ]]; then artist="Unknown Artist"; fi
if [[ -z "$title" ]]; then title="Unknown Title"; fi

# Icons (Nerd Font recommended)
icon_play=""     # play icon
icon_pause=""    # pause icon
icon_next=""     # next track
icon_prev=""     # previous track
icon_stop=""     # stop icon
icon_music=""    # music note

# Status icon and class
case "$status" in
  Playing) status_icon="$icon_pause"; status_class="playing" ;;
  Paused) status_icon="$icon_play"; status_class="paused" ;;
  Stopped) status_icon="$icon_stop"; status_class="stopped" ;;
  *) status_icon="$icon_music"; status_class="stopped" ;;
esac

# Compose display text
display_text="$status_icon $artist - $title"

# Output JSON for Waybar
# Supports custom buttons clickable by whole widget (Waybar limitations)
# Clicks defined in config (see below)

jq -n --arg text "$display_text" --arg class "$status_class" --arg tooltip "$artist\n$title\n$album" '{
  text: $text,
  class: $class,
  tooltip: $tooltip
}'
