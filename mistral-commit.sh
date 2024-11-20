#!/bin/bash

# Check for staged changes
if ! git diff --cached --quiet; then
    git_diff=$(git diff --cached)
else
    echo "No staged changes to commit."
    exit 1
fi

# Generate commit message using Mistral
commit_message=$(ollama run mistral --prompt "Write a concise git commit message for the following changes: $git_diff")

# Display the commit message
echo "Generated Commit Message:"
echo "$commit_message"

# Ask for confirmation
read -p "Use this commit message? (y/n): " confirm
if [ "$confirm" = "y" ]; then
    git commit -m "$commit_message"
else
    echo "Commit aborted."
    exit 1
fi

