#!/usr/bin/env bash

# Set screenshot directory
screenshot_dir="$HOME/Pictures/Screenshots"

# Generate file name with timestamp
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
filename="screenshot-$timestamp.png"
location="$screenshot_dir/$filename"

# Take the screenshot
grim "$location"

# Send a notification with the image as the icon
notify-send --icon="$location" "Screenshot Saved" "Saved to: $location"