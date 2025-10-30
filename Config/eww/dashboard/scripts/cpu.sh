#!/bin/bash

case $1 in
usage)
  top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)}'
  ;;
temp)
  # Try multiple methods to get CPU temp
  if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
    temp=$(cat /sys/class/thermal/thermal_zone0/temp)
    echo $((temp / 1000))
  elif command -v sensors &>/dev/null; then
    sensors | grep -i 'Package id 0:' | awk '{print int($4)}' | tr -d '+'
  else
    echo "N/A"
  fi
  ;;
esac
