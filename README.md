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
│   └── daily-commit.sh         # Script executed by the workflow
├── log.txt                     # File updated daily
└── README.md                   # Project documentation
```

---

## ⚙️ GitHub Actions Workflow

The workflow file is located at: `.github/workflows/daily-commit.yaml`.

You can test the workflow locally using [act](https://github.com/nektos/act):

1. **Install `act`** if you haven't already.
2. **Create a `.secrets` file** with your GitHub token:
  ```plaintext
  GITHUB_TOKEN=your_personal_access_token
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
