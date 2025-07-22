#!/usr/bin/env bash

# NixOS Flake Update Checker for Waybar
# Outputs number of pending flake updates (but does not apply them)
# Uses Nerd Font icons in "text" field
# Caches state in ~/.cache/nix-updates

# ===== Config =====
NIXOS_CONFIG_PATH="$HOME/projects/nixcfg"
CACHE_DIR="$HOME/.cache/nix-updates"
STATE_FILE="$CACHE_DIR/state.json"
BOOT_MARKER_FILE="$CACHE_DIR/boot-marker"

CHECK_INTERVAL=3600  # seconds
SKIP_AFTER_BOOT=true
GRACE_PERIOD=60

# ===== Nerd Font Icons =====
ICON_UPDATED="󰗠"       # nf-fa-check
ICON_HAS_UPDATES="󰚰"   # nf-fa-wrench
ICON_ERROR="󰀦"         # nf-fa-exclamation_triangle
ICON_CHECKING="󰓦"      # nf-fa-refresh

# ===== Dependency Check =====
function check_dependencies() {
    local missing=()

    for cmd in nix nvd jq; do
        command -v "$cmd" &>/dev/null || missing+=("$cmd")
    done

    if [ "${#missing[@]}" -ne 0 ]; then
        local tooltip="Missing dependencies: ${missing[*]}"
        echo "{\"text\":\"$ICON_ERROR !\",\"alt\":\"error\",\"tooltip\":\"$tooltip\",\"timestamp\":$(date +%s)}"
        exit 1
    fi
}

# ===== Grace Period After Boot =====
function in_grace_period() {
    local now=$(date +%s)
    local uptime=$(awk '{print int($1)}' /proc/uptime)
    local boot_time=$((now - uptime))

    if [ ! -f "$BOOT_MARKER_FILE" ]; then
        echo "$now" > "$BOOT_MARKER_FILE"
        return 0
    fi

    local last_boot=$(cat "$BOOT_MARKER_FILE")
    (( now - last_boot < GRACE_PERIOD )) && return 0

    return 1
}

# ===== Should We Run Check Now =====
function should_check() {
    if [ ! -f "$STATE_FILE" ]; then
        return 0
    fi

    local last_check
    last_check=$(jq -r '.timestamp // 0' "$STATE_FILE")
    local now=$(date +%s)
    (( now - last_check >= CHECK_INTERVAL ))
}

# ===== Run Flake Update in Temp =====
function check_updates() {
    local tmpdir
    tmpdir=$(mktemp -d)
    trap "rm -rf '$tmpdir'" EXIT

    cp -r "$NIXOS_CONFIG_PATH" "$tmpdir/config"
    cd "$tmpdir/config" || return 1

    nix flake update &>/dev/null || {
        echo "{\"text\":\"$ICON_ERROR !\",\"alt\":\"error\",\"tooltip\":\"Flake update failed\",\"timestamp\":$(date +%s)}" > "$STATE_FILE"
        return 1
    }

    local diff_output
    diff_output=$(nvd diff "$NIXOS_CONFIG_PATH/flake.lock" "$tmpdir/config/flake.lock" 2>/dev/null)

    local updates=0
    local tooltip_lines=()

    while IFS= read -r line; do
        if [[ "$line" =~ \[U.*\] ]]; then
            ((updates++))
            local name old new
            name=$(echo "$line" | awk '{print $2}')
            old=$(echo "$line" | awk '{print $3}')
            new=$(echo "$line" | awk '{print $5}')
            tooltip_lines+=("$name: $old → $new")
        fi
    done <<< "$diff_output"

    local tooltip
    if (( updates == 0 )); then
        tooltip="System up to date"
        echo "{\"text\":\"$ICON_UPDATED 0\",\"alt\":\"updated\",\"tooltip\":\"$tooltip\",\"timestamp\":$(date +%s)}" > "$STATE_FILE"
    else
        tooltip=$(printf "%s\n" "${tooltip_lines[@]}" | sed 's/"/\\"/g')
        echo "{\"text\":\"$ICON_HAS_UPDATES $updates\",\"alt\":\"has-updates\",\"tooltip\":\"$tooltip\",\"timestamp\":$(date +%s)}" > "$STATE_FILE"
    fi
}

# ===== Output Cached State or Fallback =====
function output_json() {
    if [ -s "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "{\"text\":\"$ICON_CHECKING ?\",\"alt\":\"unknown\",\"tooltip\":\"No update data\",\"timestamp\":$(date +%s)}"
    fi
}

# ===== Main Entrypoint =====
function main() {
    mkdir -p "$CACHE_DIR"
    check_dependencies

    if $SKIP_AFTER_BOOT && in_grace_period; then
        output_json
        exit 0
    fi

    if should_check; then
        if ! check_updates; then
            :
        fi
    fi

    output_json
}

main
