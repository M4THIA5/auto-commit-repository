# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Bash + GitHub Actions project that keeps a GitHub contribution graph active. Each run makes **two independent commits/pushes to `main`**: one antedated commit to backfill the past contribution graph, and one current-day commit that regenerates `DAILY_INFORMATIONS.md` from live APIs (weather, quote, advice). There is no application code, build, or test suite — everything is shell scripts driven by a scheduled workflow.

## Commands

Dependencies: `bash`, `git`, `curl`, `jq` (and `act` for local runs).

- **Run the whole workflow locally** (mirrors CI): `act -j daily-commit --secret-file .secrets`
  - `.actrc` pins the runner image; `.secrets` is gitignored and must define `GITHUB_TOKEN`, `COMMITER_NAME`, `COMMITER_EMAIL`, `OPEN_WEATHER_API_KEY`.
- **Run individual scripts** (requires the same vars exported in your shell): `./scripts/daily-info-update.sh`, `./scripts/populate-contributions.sh`, or the full orchestrator `./scripts/daily-commit.sh`.
  - Note: every script except `daily-info-update.sh` **commits and pushes to `main`** as a side effect — see Gotchas before running locally against the real remote.

## Architecture

Trigger → orchestrator → two sub-scripts:

1. **`.github/workflows/daily-commit.yaml`** — cron `0 8 * * *` (08:00 UTC = 10:00 Paris CEST) plus manual `workflow_dispatch`. Passes the four secrets as env vars and runs `./scripts/daily-commit.sh`.
2. **`scripts/daily-commit.sh`** — validates the secrets are present, then runs `populate-contributions.sh`, then `daily-info-update.sh`, configures the git author, `git add . && git commit`, rewrites the `origin` URL with the token, and pushes `main`.
3. **`scripts/populate-contributions.sh`** — backfills the past contribution graph. Sources the counter, computes a date N days in the past, writes `past-commit.txt`, and commits it with `GIT_COMMITTER_DATE` / `--date` set in the past so the commit lands on an earlier calendar day. It then **increments the counter and pushes on its own**.
4. **`scripts/daily-info-update.sh`** — regenerates `DAILY_INFORMATIONS.md` (an HTML-in-Markdown dashboard) from OpenWeather (hardcoded Paris coords, needs `OPEN_WEATHER_API_KEY`), ZenQuotes, and AdviceSlip. Pure file generation — it does not commit.

## Gotchas

- **`scripts/past-commit-counter.sh` is mutable state, not logic.** It's a single line (`past_commits_counter=N`) that is *sourced* by `populate-contributions.sh`, which then **increments it by 2, overwrites the file, and commits it back** each run. When editing the backfill logic, preserve this read-source-then-rewrite pattern.
- **Scripts push directly to `main`** and rewrite the `origin` remote to embed `GITHUB_TOKEN` (`https://x-access-token:...`). Do not run them against the real repo while testing — use `act` or a throwaway clone.
- **Two commits per run**, from two different scripts, each with its own push.
- **README is partially stale**: it attributes the past-commit/counter work to `daily-commit.sh` (it actually lives in `populate-contributions.sh`). Trust the scripts over the README.
