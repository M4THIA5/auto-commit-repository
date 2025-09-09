#!/usr/bin/env bash
set -euo pipefail

TIME_PARIS=$(TZ="Europe/Paris" date +"%A %d %B %Y - %I:%M%p")

WEATHER_PARIS_DATA=$(curl -s "wttr.in/Paris?format=j1")

TEMP_C=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].temp_C')
WEATHER_DESC=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].weatherDesc[0].value')
WIND_SPEED_KMPH=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].windspeedKmph')
UV_INDEX=$(echo "$WEATHER_PARIS_DATA" | jq -r '.current_condition[0].uvIndex')

cat <<EOF > DAILY_INFORMATIONS.md
# 🌍 Daily Informations

## 📅 Date & Heure Paris
- **${TIME_PARIS}**



## 🌦️ Météo à Paris
- **Température** : ${TEMP_C}°C  
- **Conditions** : ${WEATHER_DESC}  
- **Vent** : ${WIND_SPEED_KMPH} km/h  
- **Indice UV** : ${UV_INDEX}  

---
*(Données fournies par [wttr.in](https://wttr.in/Paris))*  
EOF

echo "DAILY_INFORMATIONS.md has been updated."