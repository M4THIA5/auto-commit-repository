
#!/bin/bash
. ./scripts/past-commit-counter.sh

num_commits=$((RANDOM % 6)) # Random commit number between 0 and 5 to add
current_date=$(date -d "-$past_commits_counter days" +"%Y-%m-%d")

past_commits_counter=$((past_commits_counter + 1))
echo "past_commits_counter=$past_commits_counter" > ./scripts/past-commit-counter.sh

git config user.name "$COMMITER_NAME"
git config user.email "$COMMITER_EMAIL"

file="past-commit.txt"
echo "Commit made on $current_date" > "$file"

# Add the file to staging
git add "$file"

# Commit with an antedated timestamp
GIT_COMMITTER_NAME="$COMMITER_NAME" GIT_COMMITTER_DATE="$current_date 12:00:00" git commit --date="$current_date 12:00:00" -m "feat: automated daily update" || echo "No changes to commit"

git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/M4THIA5/auto-commit-repository.git
git push origin main
