#!/usr/bin/env bash

# === Config ===
NIX_CONFIG="$HOME/projects/nixcfg"
CACHE_DIR="$HOME/.cache/nix-update"
JSON_OUT="$CACHE_DIR/waybar.json"

ICON_DIR="$HOME/.icons"
HOST=$(hostname)

# Ensure cache dir exists
mkdir -p "$CACHE_DIR"

# === Functions ===

function notify() {
    local icon="$1"
    local title="$2"
    local msg="$3"
    notify-send  "$title" "$msg" -e
}

function output_json() {
    local count="$1"
    local tooltip="$2"
    local alt="$3"
    echo "{\"text\":\"󱄅 $count\", \"tooltip\":\"$tooltip\", \"alt\":\"$alt\"}" > "$JSON_OUT"
}

function check_updates() {
    local tmpdir
    tmpdir=$(mktemp -d)
    trap "rm -rf $tmpdir" EXIT

    cd "$tmpdir" || exit 1
    cp -r "$NIX_CONFIG"/* .

    notify "updates-checking" "Checking for Updates" "Please wait..."

    # Update flake
    if ! nix flake update > /dev/null 2>&1; then
        notify "updates-failed" "Update Check Failed" "flake update failed"
        output_json "!" "flake update failed" "error"
        return 1
    fi

    # Build system
    if ! nix build ".#nixosConfigurations.$HOST.config.system.build.toplevel" > /dev/null 2>&1; then
        notify "updates-failed" "Update Check Failed" "nixos build failed"
        output_json "!" "nixos build failed" "error"
        return 1
    fi

    # Compare with current system
    local diff
    diff=$(nvd diff /run/current-system ./result)

    if echo "$diff" | grep -q '\[U'; then
        # Updates found
        local updates
        updates=$(echo "$diff" | grep -c '\[U')
        local summary
        summary=$(echo "$diff" | grep '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n')
        notify "updates-pending" "Updates Available" "$updates packages can be updated"
        output_json "$updates" "$summary" "has-updates"
    else
        # No updates
        notify "updates-complete" "System Up to Date" "No updates found"
        output_json "0" "System is up to date" "updated"
    fi
}

# === Run ===
check_updates
