#!/bin/bash

# Get your API key from openweathermap.org
API_KEY="YOUR_API_KEY_HERE"
CITY="YOUR_CITY_NAME" # e.g., "Mumbai" or "New Delhi"

CACHE_FILE="/tmp/weather_cache.json"
CACHE_TIME=600 # 10 minutes

# Check cache
if [ -f "$CACHE_FILE" ]; then
  CACHE_AGE=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
  if [ $CACHE_AGE -lt $CACHE_TIME ]; then
    weather_data=$(cat "$CACHE_FILE")
  fi
fi

# Fetch new data if cache is old
if [ -z "$weather_data" ]; then
  weather_data=$(curl -sf "https://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric")
  if [ -n "$weather_data" ]; then
    echo "$weather_data" >"$CACHE_FILE"
  fi
fi

case $1 in
temp)
  echo "$weather_data" | jq -r '.main.temp // "N/A"' | awk '{print int($1)}'
  ;;
desc)
  echo "$weather_data" | jq -r '.weather[0].description // "No data"'
  ;;
icon)
  condition=$(echo "$weather_data" | jq -r '.weather[0].main // "Clear"')
  case $condition in
  Clear) echo "" ;;
  Clouds) echo "" ;;
  Rain | Drizzle) echo "" ;;
  Thunderstorm) echo "" ;;
  Snow) echo "" ;;
  Mist | Fog) echo "" ;;
  *) echo "" ;;
  esac
  ;;
location)
  echo "$weather_data" | jq -r '.name // "Unknown"'
  ;;
esac
