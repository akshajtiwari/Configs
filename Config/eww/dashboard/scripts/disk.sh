#!/bin/bash

case $1 in
usage)
  df -h / | awk 'NR==2 {print int($5)}'
  ;;
used)
  df -h / | awk 'NR==2 {print int($3)}'
  ;;
total)
  df -h / | awk 'NR==2 {print int($2)}'
  ;;
esac
