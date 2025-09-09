#!/usr/bin/env bash
set -euo pipefail

rm -f log.txt

if ! command -v jq &> /dev/null; then
  echo "jq not found. Installing jq..."
  sudo apt-get update
  sudo apt-get install -y jq
fi

TIME_PARIS=$(curl -s http://worldtimeapi.org/api/timezone/Europe/Paris | jq -r '.datetime')
echo "Current Paris time: $TIME_PARIS" >> log.txt
echo "Done"
