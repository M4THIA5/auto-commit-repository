# 🔄 Daily Auto Commit

This repository uses **GitHub Actions** to automatically make a commit every day.  
Use cases include logging, testing CI/CD pipelines, or keeping your contribution graph active.

---

## 🚀 How It Works

Every day at **00:00 UTC**, a GitHub Actions workflow runs:

1. **Checks out** the repository.
2. **Appends** the current date and time to `log.txt` (or any file you choose).
3. **Commits** the change with a timestamped commit message.
4. **Pushes** the commit to the repository.

---

## 📂 Project Structure

```
.
├── .github/
│   └── workflows/
│       └── daily-commit.yaml   # GitHub Actions workflow
├── scripts/
│   ├── daily-commit.sh         # Script executed by the workflow
│   └── daily-info-update.sh    # Script to update the informations file
├── DAILY_INFORMATIONS.md       # File updated daily
└── README.md                   # Project documentation
```

---

## ⚙️ GitHub Actions Workflow

The workflow file is located at: `.github/workflows/daily-commit.yaml`.

### 🔑 Adding Secrets: `COMMIT_NAME` & `COMMIT_EMAIL`

To securely provide your commit author information to the workflow, add the following secrets to your GitHub repository:

1. Go to your repository on GitHub.
2. Click on **Settings** > **Secrets and variables** > **Actions**.
3. Click **New repository secret**.
4. Add a secret named `COMMIT_NAME` with your desired commit author name.
5. Add another secret named `COMMIT_EMAIL` with your email address.
6. Save each secret.

These secrets will be available to your workflow and used for commit attribution.

### ▶️ Run the Workflow Manually on GitHub

You can trigger the workflow directly from the GitHub UI:

1. Go to the **Actions** tab of your repository.
2. Select the **Daily Auto Commit** workflow from the list.
3. Click the **"Run workflow"** button.
4. Optionally, choose a branch and provide any required inputs.
5. Click **"Run workflow"** to start the action immediately.

This is useful for testing or making an immediate commit outside the scheduled time.

You can test the workflow locally using [act](https://github.com/nektos/act):

1. **Install `act`** if you haven't already.
2. **Create a `.secrets` file** with your GitHub token:
  ```plaintext
  GITHUB_TOKEN=your_personal_access_token
  COMMIT_NAME=YourName
  COMMIT_EMAIL=you@example.com
  ```
3. **Run the workflow locally:**
  ```sh
  act schedule --secret-file .secrets
  ```

### 📅 Customization

- **Change the cron schedule:**  
  Modify the cron expression to control when it runs.  
  Example: run at 6 AM UTC every day:  
  ```yaml
  - cron: "0 6 * * *"
  ```

- **Change the file being updated:**  
  Replace `log.txt` with any file you want to modify or generate dynamically.

- **Use a separate branch:**  
  You can push to a branch like `auto-updates` instead of `main` to keep commits isolated.

---

## 💡 Use Cases

- Keep your GitHub contribution graph green 🌱
- Test CI/CD pipelines on a daily basis
- Keep a running log of days/timestamps
- Trigger downstream workflows automatically
