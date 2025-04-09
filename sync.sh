#!/bin/bash

REPO_PATH="/Users/lukashahn/files.lukashahn.art"
LOG_FILE="$REPO_PATH/sync.log"

cd $REPO_PATH
echo ""
echo ""
echo ""
echo "Watching for changes in $(pwd)..."
echo ""
echo "I am am... $(whoami) (not a real religious man)."
echo ""
echo "Current git config:"
echo "-------------------------------------"
git config --list
echo "-------------------------------------"
echo ""
echo "Current git status:"
echo "-------------------------------------"
git status
echo "-------------------------------------"
echo ""

EXCLUDES=$(grep -Ev '^#|^$' .gitignore | awk '{print "--exclude=" $1}' | xargs)

/opt/homebrew/bin/fswatch -o . $EXCLUDES | while read change; do
    echo "Changes detected, syncing..."
git add . 
git commit -m "Auto commit: $(date)" 
git push origin main   # Change "main" if your branch name is different
done