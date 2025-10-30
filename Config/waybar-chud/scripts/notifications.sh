#!/bin/bash

if [ "$1" = "click" ]; then
  # Dismiss all visible notifications
  makoctl dismiss -a
else
  # Count current notifications
  count=$(makoctl list | grep -c "app-name" 2>/dev/null || echo "0")
  echo "$count"
fi
