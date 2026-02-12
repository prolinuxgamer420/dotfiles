#!/bin/bash

# Define where to store the count (optional, can be done in one command)
update_count_file="/tmp/polybar_update_count"

# Use checkupdates for repo packages and an AUR helper for AUR packages
# Combine the counts
updates=$(checkupdates 2>/dev/null; paru -Qum 2>/dev/null)
count=$(echo "$updates" | wc -l)

# If no updates, count will be 0, otherwise it's the actual number
if [ "$updates" = "" ]; then
    count=0
fi

echo $count > "$update_count_file"

# Output for Polybar
if [ "$count" -gt 0 ]; then
    echo "󰚰 $count" # An icon and the count
else
    echo "" # Empty line hides the module
fi
