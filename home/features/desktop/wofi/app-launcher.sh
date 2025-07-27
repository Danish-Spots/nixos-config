#!/usr/bin/env bash

if pidof wofi > /dev/null; then
        exit  0
fi

# Prompt user to select a .desktop app using wofi
D=$(wofi --define=drun-print_desktop_file=true)

[[ -z "$D" ]] && exit 0

# Check if the output is in the form "name.desktop /path/to/desktop/file"
if [[ "$D" == *.desktop\ * ]]; then
  # Extract the name and path, reconstruct as "name.desktop:/path"
  desktop_entry="${D%%.desktop *}.desktop"
  desktop_path="${D#*.desktop }"
  formatted="${desktop_entry}:${desktop_path}"
else
  # Fallback: use the raw selection
  formatted="$D"
fi

# Launch with uwsm
exec uwsm app -- "$formatted"
