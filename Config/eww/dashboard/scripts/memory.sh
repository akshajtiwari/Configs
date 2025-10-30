#!/bin/bash

case $1 in
usage)
  free | grep Mem | awk '{print int($3/$2 * 100)}'
  ;;
used)
  free -g | grep Mem | awk '{print $3}'
  ;;
total)
  free -g | grep Mem | awk '{print $2}'
  ;;
esac
