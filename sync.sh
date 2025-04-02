#!/bin/bash

REPO_PATH="/Users/blackout/files.lukashahn.art"
LOG_FILE="$REPO_PATH/sync.log"
git config --global --add safe.directory /Users/blackout/files.lukashahn.art
cd $REPO_PATH

echo "Watching for changes in $(pwd)..."
whoami

sudo -u blackout git status

EXCLUDES=$(grep -Ev '^#|^$' .gitignore | awk '{print "--exclude=" $1}' | xargs)

/usr/local/bin/fswatch -o . $EXCLUDES | while read change; do
    echo "Changes detected, syncing..."
    sudo -u blackout git add . 
    git commit -m "Auto commit: $(date)" 
    git push origin main   # Change "main" if your branch name is different
done