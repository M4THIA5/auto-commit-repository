#!/usr/bin/env bash
set -euo pipefail

DATE_PARIS=$(TZ="Europe/Paris" date +"%A %d %B %Y")
HEURE_PARIS=$(TZ="Europe/Paris" date +"%I:%M%p")

# Extract relevant weather information
WEATHER_PARIS_DATA=$(curl -s "https://api.openweathermap.org/data/2.5/weather?lat=48.866669&lon=2.33333&appid=${OPEN_WEATHER_API_KEY}&units=metric")

TEMP_C=$(echo "$WEATHER_PARIS_DATA" | jq -r '.main.temp')
FEELS_LIKE_C=$(echo "$WEATHER_PARIS_DATA" | jq -r '.main.feels_like')
TEMP_MIN_C=$(echo "$WEATHER_PARIS_DATA" | jq -r '.main.temp_min')
TEMP_MAX_C=$(echo "$WEATHER_PARIS_DATA" | jq -r '.main.temp_max')
PRESSURE=$(echo "$WEATHER_PARIS_DATA" | jq -r '.main.pressure')
HUMIDITY=$(echo "$WEATHER_PARIS_DATA" | jq -r '.main.humidity')
WEATHER_DESC=$(echo "$WEATHER_PARIS_DATA" | jq -r '.weather[0].description')
WIND_SPEED_KMPH=$(echo "$WEATHER_PARIS_DATA" | jq -r '.wind.speed')
WIND_DIRECTION=$(echo "$WEATHER_PARIS_DATA" | jq -r '.wind.deg')
CLOUD_COVERAGE=$(echo "$WEATHER_PARIS_DATA" | jq -r '.clouds.all')
VISIBILITY=$(echo "$WEATHER_PARIS_DATA" | jq -r '.visibility')
SUNRISE=$(date -d @"$(echo "$WEATHER_PARIS_DATA" | jq -r '.sys.sunrise')" +"%H:%M:%S")
SUNSET=$(date -d @"$(echo "$WEATHER_PARIS_DATA" | jq -r '.sys.sunset')" +"%H:%M:%S")

# # Quote of the day
QUOTE_DATA=$(curl -s "https://zenquotes.io/api/random")

QUOTE_TEXT=$(echo "$QUOTE_DATA" | jq -r '.[0].q')
QUOTE_AUTHOR=$(echo "$QUOTE_DATA" | jq -r '.[0].a')

# random advice
ADVICE_DATA=$(curl -s "https://api.adviceslip.com/advice")
ADVICE_TEXT=$(echo "$ADVICE_DATA" | jq -r '.slip.advice')

cat <<EOF > DAILY_INFORMATIONS.md
# 🌍 Daily Informations

## 🕒 Current Date and Time in Paris
<div style="text-align:center; margin: 18px 0; padding: 12px 0; background: #f7fafc; border-radius: 8px; box-shadow: 0 1px 6px rgba(33,150,243,0.08);">
  <span style="font-size:2em; font-weight:bold; color:#4F8A8B;">
    ${DATE_PARIS} - ${HEURE_PARIS}
  </span>
</div>

## 🌦️ Weather in Paris
<div style="display: flex; flex-wrap: wrap; gap: 12px; justify-content: center; margin-bottom: 18px;">
  <div style="background: #e3f2fd; border-radius: 12px; padding: 16px; box-shadow: 0 2px 8px rgba(33,150,243,0.1); width: 45%; text-align: center;">
    <strong>🌡️ Temperature</strong>
    <p>${TEMP_C}°C (Feels like: ${FEELS_LIKE_C}°C)</p>
    <small>Min: ${TEMP_MIN_C}°C, Max: ${TEMP_MAX_C}°C</small>
  </div>
  <div style="background: #e3f2fd; border-radius: 12px; padding: 16px; box-shadow: 0 2px 8px rgba(33,150,243,0.1); width: 45%; text-align: center;">
    <strong>🌤️ Conditions</strong>
    <p>${WEATHER_DESC}</p>
    <small>Pressure: ${PRESSURE} hPa, Humidity: ${HUMIDITY}%</small>
  </div>
  <div style="background: #e3f2fd; border-radius: 12px; padding: 16px; box-shadow: 0 2px 8px rgba(33,150,243,0.1); width: 45%; text-align: center;">
    <strong>💨 Wind</strong>
    <p>${WIND_SPEED_KMPH} km/h</p>
    <small>Direction: ${WIND_DIRECTION}°</small>
  </div>
  <div style="background: #e3f2fd; border-radius: 12px; padding: 16px; box-shadow: 0 2px 8px rgba(33,150,243,0.1); width: 45%; text-align: center;">
    <strong>☁️ Cloud Coverage</strong>
    <p>${CLOUD_COVERAGE}%</p>
  </div>
  <div style="background: #e3f2fd; border-radius: 12px; padding: 16px; box-shadow: 0 2px 8px rgba(33,150,243,0.1); width: 45%; text-align: center;">
    <strong>🌅 Sunrise</strong>
    <p>${SUNRISE}</p>
  </div>
  <div style="background: #e3f2fd; border-radius: 12px; padding: 16px; box-shadow: 0 2px 8px rgba(33,150,243,0.1); width: 45%; text-align: center;">
    <strong>🌇 Sunset</strong>
    <p>${SUNSET}</p>
  </div>
</div>

> <span style="color:#4F8A8B;">*Data provided by <a href="https://openweathermap.org/" style="color:#1976d2;">openweathermap.org</a>*</span>

<table>
  <tr>
    <td width="48%" valign="top">
      <h3>💬 Quote of the Day</h3>
      <div style="background: #f9f9f9; border-left: 4px solid #4F8A8B; padding: 16px 20px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.04); word-break:break-word;">
        <span style="font-size:1.25em; font-style:italic; color:#333;">“${QUOTE_TEXT}”</span>
        <br>
        <span style="display:block; margin-top:10px; text-align:right; color:#4F8A8B; font-weight:bold;">
          — <em>${QUOTE_AUTHOR}</em>
        </span>
      </div>
    </td>
    <td width="4%" align="center" style="border-left:1px solid #ccc;">
      <!-- vertical separator -->
    </td>
    <td width="48%" valign="top">
      <h3>📝 Advice of the Day</h3>
      <div style="background: #f0f8ff; border-left: 4px solid #FFB400; padding: 16px 20px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.04); word-break:break-word;">
        <span style="font-size:1.15em; color:#333;">
          <strong>💡</strong> <em>“${ADVICE_TEXT}”</em>
        </span>
      </div>
    </td>
  </tr>
</table>

EOF

echo "DAILY_INFORMATIONS.md has been updated."