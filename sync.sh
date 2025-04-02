#!/bin/bash

REPO_PATH="/Users/blackout/files.lukashahn.art"
LOG_FILE="$REPO_PATH/sync.log"

cd $REPO_PATH
echo "\n\n\n"
echo "Watching for changes in $(pwd)...\n"

echo "I am am... $(whoami) (not a real religious man).\n"
echo "Current git config:"
echo "-------------------------------------"
git config --list
echo "-------------------------------------"

echo "Current git status:"
echo "-------------------------------------"
git status
echo "-------------------------------------"

EXCLUDES=$(grep -Ev '^#|^$' .gitignore | awk '{print "--exclude=" $1}' | xargs)

/usr/local/bin/fswatch -o . $EXCLUDES | while read change; do
    echo "Changes detected, syncing..."
git add . 
git commit -m "Auto commit: $(date)" 
git push origin main   # Change "main" if your branch name is different
done