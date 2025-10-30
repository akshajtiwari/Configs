#!/bin/bash

case $1 in
usage)
  if command -v nvidia-smi &>/dev/null; then
    nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits
  elif command -v radeontop &>/dev/null; then
    radeontop -d - -l 1 | grep -o 'gpu [0-9]\+' | awk '{print $2}'
  else
    echo "0"
  fi
  ;;
temp)
  if command -v nvidia-smi &>/dev/null; then
    nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits
  elif command -v sensors &>/dev/null; then
    sensors | grep -i 'edge:' | awk '{print int($2)}' | tr -d '+' | head -1
  else
    echo "N/A"
  fi
  ;;
esac
