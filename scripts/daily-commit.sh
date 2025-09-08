#!/usr/bin/env bash
set -e

# Update log
echo "Daily update: $(date -u)" >> log.txt

# Configure Git
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

git add .
git commit -m "Automated commit on $(date -u)" || echo "No changes to commit"

# Push using token (works both on GitHub Actions and act local)
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN not defined"
  exit 1
fi

git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/M4THIA5/auto-commit-repository.git
git push origin main
