#!/usr/bin/env bash
set -euo pipefail

DATE_PARIS=$(TZ="Europe/Paris" date +"%A %d %B %Y")
HEURE_PARIS=$(TZ="Europe/Paris" date +"%I:%M%p")

# Extract relevant weather information
WEATHER_PARIS_DATA=$(curl -s "wttr.in/Paris?format=j1")

TEMP_C=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].temp_C')
WEATHER_DESC=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].weatherDesc[0].value')
WIND_SPEED_KMPH=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].windspeedKmph')
UV_INDEX=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].uvIndex')

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
<table style="width:100%; background:linear-gradient(90deg, #e3f2fd 0%, #f7fafc 100%); border-radius:12px; box-shadow:0 2px 8px rgba(33,150,243,0.10); margin-bottom:18px; border-collapse:separate; border-spacing:0;">
  <thead>
    <tr>
      <th style="padding:12px 8px; color:#1976d2; font-size:1.1em; background:#f0f8ff; border-top-left-radius:12px; text-align:center;">🌡️ Temperature</th>
      <th style="padding:12px 8px; color:#1976d2; font-size:1.1em; background:#f0f8ff; text-align:center;">🌤️ Conditions</th>
      <th style="padding:12px 8px; color:#1976d2; font-size:1.1em; background:#f0f8ff; text-align:center;">💨 Wind</th>
      <th style="padding:12px 8px; color:#1976d2; font-size:1.1em; background:#f0f8ff; border-top-right-radius:12px; text-align:center;">🔆 UV Index</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="padding:16px 8px; font-weight:bold; color:#4F8A8B; font-size:1.3em; text-align:center; background:#ffffff; border-bottom-left-radius:12px; box-shadow:0 1px 4px rgba(33,150,243,0.07);">${TEMP_C}°C</td>
      <td style="padding:16px 8px; color:#333; font-size:1.1em; text-align:center; background:#ffffff; box-shadow:0 1px 4px rgba(33,150,243,0.07);">${WEATHER_DESC}</td>
      <td style="padding:16px 8px; color:#333; font-size:1.1em; text-align:center; background:#ffffff; box-shadow:0 1px 4px rgba(33,150,243,0.07);">${WIND_SPEED_KMPH} km/h</td>
      <td style="padding:16px 8px; color:#333; font-size:1.1em; text-align:center; background:#ffffff; border-bottom-right-radius:12px; box-shadow:0 1px 4px rgba(33,150,243,0.07);">${UV_INDEX}</td>
    </tr>
  </tbody>
</table>

> <span style="color:#4F8A8B;">*Data provided by <a href="https://wttr.in/Paris" style="color:#1976d2;">wttr.in</a>*</span>

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