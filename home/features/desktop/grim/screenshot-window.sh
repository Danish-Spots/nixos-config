#!/usr/bin/env bash

#!/usr/bin/env bash

# Screenshot save directory
screenshot_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_dir"

# Timestamped filename
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
filename="window-$timestamp.png"
location="$screenshot_dir/$filename"

# Let user select a window/region (mouse click)
geometry=$(slurp -w 0 -b "#00000000" -c "#ffffff88")

# Check if user selected a region
if [ -z "$geometry" ]; then
  notify-send "Screenshot Cancelled" "No window selected."
  exit 1
fi

# Capture the selected region
grim -g "$geometry" "$location"

# Send notification with preview
notify-send --icon="$location" "Window Screenshot Saved" "Saved to: $location"
