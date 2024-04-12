#!/usr/bin/env zsh

for i in {1..5}; do
    ping -c 1 8.8.8.8 &> /dev/null && break
    if [ $i -eq 5 ]; then
        echo "Network not available"
        exit 1
    fi
    sleep 2
done



API_KEY="${WEATHER_API_KEY}"
LAT="${MY_LAT}"
LON="${MY_LON}"
URL="http://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&appid=${API_KEY}&units=metric"

weather_icon() {
    case $1 in
        "Clear") echo "" ;;
        "Clouds") echo "" ;;
        "Rain") echo "" ;;
        "Snow") echo "" ;;
        "Thunderstorm") echo "" ;;
        "Drizzle") echo "" ;;
        "Mist") echo "🌫" ;;
        "Fog") echo "🌫" ;;
        "Tornado") echo "🌪" ;;
        "Dust") echo "🌫" ;;
        "Ash") echo "🌫" ;;
        "Squall") echo "🌬" ;;
        *) echo "❓" ;;
    esac
}

WEATHER_JSON=$(curl -s "${URL}")
TEMP=$(echo "${WEATHER_JSON}" | jq '.main.temp? // "N/A"' | xargs printf "%.1f")
WEATHER=$(echo "${WEATHER_JSON}" | jq '.weather[0].main' | tr -d '"')
WEATHER_EMOJI=$(weather_icon "${WEATHER}")

echo "${WEATHER_EMOJI} ${TEMP}°C"
