#!/bin/bash

REPO_PATH="/Users/blackout/files.lukashahn.art"
LOG_FILE="$REPO_PATH/sync.log"

cd $REPO_PATH

fswatch -o . \
        --exclude ".git" \
        --exclude "*.log" | while read change; do
    echo "Changes detected, syncing..." | tee -a $LOG_FILE
    git add . | tee -a $LOG_FILE
    git commit -m "Auto commit: $(date)" | tee -a $LOG_FILE
    git push origin main | tee -a $LOG_FILE  # Change "main" if your branch name is different
done