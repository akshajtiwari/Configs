#!/bin/bash

if ! playerctl status &>/dev/null; then
  echo '{"text":" No media","class":"stopped"}'
  exit
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ -z "$artist" ] && [ -z "$title" ]; then
  echo '{"text":" No media","class":"stopped"}'
else
  text="$title"
  if [ -n "$artist" ]; then
    text="$artist - $title"
  fi
  echo "{\"text\":\" $text\",\"class\":\"playing\"}"
fi
