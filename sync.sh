#!/bin/bash

REPO_PATH="/Users/blackout/files.lukashahn.art"
cd $REPO_PATH

fswatch -o . \
        --exclude ".git" | while read change; do
    echo "Changes detected, syncing..."
    git add .
    git commit -m "Auto commit: $(date)"
    git push origin main  # Change "main" if your branch name is different
done
