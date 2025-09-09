#!/usr/bin/env bash
set -euo pipefail

# Check required secrets
if [ -z "$GITHUB_TOKEN" ] || [ -z "$COMMIT_NAME" ] || [ -z "$COMMIT_EMAIL" ]; then
  echo "Error: Missing secrets (GITHUB_TOKEN, COMMIT_NAME, COMMIT_EMAIL)"
  exit 1
fi


./scripts/daily-info-update.sh

git config user.name "$COMMIT_NAME"
git config user.email "$COMMIT_EMAIL"

git add .
git commit -m "feat: automated daily update" || echo "No changes to commit"

git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/M4THIA5/auto-commit-repository.git
git push origin main
