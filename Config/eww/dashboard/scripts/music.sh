#!/bin/bash

COVER_DIR="$HOME/.config/eww/dashboard/assets"
mkdir -p "$COVER_DIR"
DEFAULT_COVER="$COVER_DIR/default-cover.png"

case $1 in
status)
  status=$(playerctl status 2>/dev/null)
  if [ "$status" = "Playing" ]; then
    echo ""
  else
    echo ""
  fi
  ;;
cover)
  url=$(playerctl metadata mpris:artUrl 2>/dev/null)
  if [ -n "$url" ]; then
    if [[ "$url" == file://* ]]; then
      echo "${url#file://}"
    else
      cover_file="$COVER_DIR/current-cover.jpg"
      curl -s "$url" -o "$cover_file" 2>/dev/null
      echo "$cover_file"
    fi
  else
    echo "$DEFAULT_COVER"
  fi
  ;;
position)
  position=$(playerctl position 2>/dev/null)
  length=$(playerctl metadata mpris:length 2>/dev/null)
  if [ -n "$position" ] && [ -n "$length" ]; then
    length_sec=$((length / 1000000))
    if [ "$length_sec" -gt 0 ]; then
      echo $(awk "BEGIN {printf \"%.0f\", ($position / $length_sec) * 100}")
    else
      echo "0"
    fi
  else
    echo "0"
  fi
  ;;
current)
  position=$(playerctl position 2>/dev/null)
  if [ -n "$position" ]; then
    printf "%d:%02d" $((${position%.*} / 60)) $((${position%.*} % 60))
  else
    echo "0:00"
  fi
  ;;
total)
  length=$(playerctl metadata mpris:length 2>/dev/null)
  if [ -n "$length" ]; then
    length_sec=$((length / 1000000))
    printf "%d:%02d" $((length_sec / 60)) $((length_sec % 60))
  else
    echo "0:00"
  fi
  ;;
esac
