#!/bin/bash

case $1 in
ssid)
  nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2
  ;;
icon)
  status=$(nmcli -t -f STATE g)
  if [ "$status" = "connected" ]; then
    echo "󰤨"
  else
    echo "󰤭"
  fi
  ;;
down)
  rx1=$(cat /sys/class/net/[ew]*/statistics/rx_bytes | awk '{sum+=$1} END {print sum}')
  sleep 1
  rx2=$(cat /sys/class/net/[ew]*/statistics/rx_bytes | awk '{sum+=$1} END {print sum}')
  speed=$(((rx2 - rx1) / 1024))
  if [ $speed -gt 1024 ]; then
    echo "$(awk "BEGIN {printf \"%.1f\", $speed/1024}") MB/s"
  else
    echo "$speed KB/s"
  fi
  ;;
up)
  tx1=$(cat /sys/class/net/[ew]*/statistics/tx_bytes | awk '{sum+=$1} END {print sum}')
  sleep 1
  tx2=$(cat /sys/class/net/[ew]*/statistics/tx_bytes | awk '{sum+=$1} END {print sum}')
  speed=$(((tx2 - tx1) / 1024))
  if [ $speed -gt 1024 ]; then
    echo "$(awk "BEGIN {printf \"%.1f\", $speed/1024}") MB/s"
  else
    echo "$speed KB/s"
  fi
  ;;
esac
