#!/bin/bash
# Script: set_gitlab_origin.sh
# Purpose: Automate GitLab origin setup for any repo

# ---------- Configuration ----------
GITLAB_USER="bhavyashree"       # Replace with your GitLab username
REPO_NAME="devops-project"      # Replace with your repo name
BRANCH_NAME="main"              # Replace if using 'master' or another branch
# -----------------------------------

# Construct the GitLab repo URL
REPO_URL="https://gitlab.com/${GITLAB_USER}/${REPO_NAME}.git"

# Step 1: Check if inside a git repo
if [ ! -d .git ]; then
  echo "❌ Not a Git repository. Initializing..."
  git init
fi

# Step 2: Remove old origin if exists
if git remote | grep -q "origin"; then
  echo "🔁 Removing old origin..."
  git remote remove origin
fi

# Step 3: Add new GitLab origin
echo "➕ Adding new GitLab origin: $REPO_URL"
git remote add origin "$REPO_URL"

# Step 4: Verify
echo "✅ Current remote URLs:"
git remote -v

# Step 5: Push changes
echo "🚀 Pushing code to GitLab..."
git add .
git commit -m "Initial commit" 2>/dev/null
git branch -M "$BRANCH_NAME"
git push -u origin "$BRANCH_NAME"

echo "🎉 Done! Repository linked to: $REPO_URL"
