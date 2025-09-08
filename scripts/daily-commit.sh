#!/usr/bin/env bash
set -e  # stoppe si une commande échoue

echo "Daily update: $(date -u)" >> log.txt

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

git add .
git commit -m "Automated commit on $(date -u)" || echo "No changes to commit"
git push
