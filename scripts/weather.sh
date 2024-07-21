#!/usr/bin/env bash

# Weather reference: http://openweathermap.org/weather-conditions

get_icon() {
  case $1 in
    01d) icon="";;
    01n) icon="";;
    02d) icon=" ";;
    02n) icon="  ";;
    03d) icon=" ";;
    03n) icon=" ";;
    04d) icon=" ";;
    04n) icon=" ";;
    09d) icon=" ";;
    09n) icon=" ";;
    10d) icon=" ";;
    10n) icon=" ";;
    11d) icon=" ";;
    11n) icon="";;
    13d) icon=" ";;
    13n) icon=" ";;
    50d) icon="";;
    50n) icon="";;
    *) icon=" ";

    # these look great but do not always work
    # 01d) icon="☀️";;
    # 01n) icon="🌙";;
    # 02d) icon="🌤️";;
    # 02n) icon="☁️";;
    # 03d) icon="⛅";;
    # 03n) icon="☁️";;
    # 04d) icon="🌥️";;
    # 04n) icon="☁️";;
    # 09d) icon="🌦️";;
    # 09n) icon="🌧️";;
    # 10d) icon="🌦️";;
    # 10n) icon="🌧️";;
    # 11d) icon="⛈️";;
    # 11n) icon="⛈️";;
    # 13d) icon="❄️";;
    # 13n) icon="❄️";;
    # 50d) icon="🌁";;
    # 50n) icon="🌫️";;
    # *) icon="❔";
  esac
  echo $icon
}

# Cache weather data for 10min (OpenWeatherMap's default update time)
CACHE_FILE="/tmp/weather_cache.txt"
CACHE_DURATION=$((60 * 10))

# Check if cached file exists and is not older than 10min
if [ -f "$CACHE_FILE" ] && [ "$(stat -c %Y $CACHE_FILE)" -ge "$(date +%s -d "now - $CACHE_DURATION seconds")" ]; then
  # read icon, text and temp data from cache and apply color to icon
  ICON=$(cut -d ' ' -f 1 "$CACHE_FILE")
  TEMP=$(cut -d ' ' -f 2 "$CACHE_FILE")
  DESC=$(cut -d ' ' -f 3- "$CACHE_FILE")

# Else get new weather data
else
  # current location
  LOCATION=$(curl --silent http://ip-api.com/csv)
  LAT=$(echo "$LOCATION" | cut -d , -f 8)
  LON=$(echo "$LOCATION" | cut -d , -f 9)

  # OpenWeatherMap API key
  API_KEY=$(gpg --quiet -d $HOME/Documents/Keys/OpenWeatherMapAPI.txt.gpg)

  # get weather data
  WEATHER=$(curl --silent "http://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&APPID=$API_KEY&units=imperial")
  INDEX=$(echo "$WEATHER" | jq -r ".weather[0].icon")
  ICON=$(get_icon "$INDEX")
  TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)°F"
  DESC=$(echo "$WEATHER" | jq -r ".weather[0].description")
  printf "%s %s %s " "$ICON" "$TEMP" "$DESC" > "$CACHE_FILE"     # cache fresh data
fi

# Show temperature on polybar
if [ "$1" == "temp" ]; then
    echo "%{F#f0c674}$ICON%{F-} $TEMP"

# Show description on left-click
elif [ "$1" == "desc" ]; then
    ~/.config/polybar/scripts/notify-untitled.sh "$DESC"
fi
