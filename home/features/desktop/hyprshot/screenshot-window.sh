#!/usr/bin/env bash

# Set screenshot directory
screenshot_dir="@SCREENSHOT_DIR@"
# Generate file name with timestamp
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
filename="screenshot-$timestamp.png"
location="$screenshot_dir/$filename"

# Take the screenshot
hyprshot -o $screenshot_dir -f $filename -m window --freeze
