#!/usr/bin/env bash
set -euo pipefail

# Check required secrets
if [ -z "$GITHUB_TOKEN" ] || [ -z "$COMMITER_NAME" ] || [ -z "$COMMITER_EMAIL" ] || [ -z "$OPEN_WEATHER_API_KEY" ] ; then
  echo "Error: Missing secrets (GITHUB_TOKEN, COMMITER_NAME, COMMITER_EMAIL, OPEN_WEATHER_API_KEY)"
  exit 1
fi

./scripts/populate-contributions.sh

./scripts/daily-info-update.sh

git config user.name "$COMMITER_NAME"
git config user.email "$COMMITER_EMAIL"

git add .
git commit -m "feat: automated daily update" || echo "No changes to commit"

git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/M4THIA5/auto-commit-repository.git
git push origin main
