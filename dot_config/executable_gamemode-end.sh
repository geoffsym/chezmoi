#!/bin/bash
# gamemode-end.sh - Executed when a game exits under GameMode.
# Restores the state of llama-swap and ComfyUI services if they were running before.

STATE_FILE="/tmp/gamemode-ai-services-state"

# Log ending
echo "$(date): GameMode ended, restoring AI services..." >> /tmp/gamemode-hooks.log

if [ -f "$STATE_FILE" ]; then
    while IFS= read -r service; do
        if [ -n "$service" ]; then
            echo "Starting service: $service" >> /tmp/gamemode-hooks.log
            sudo systemctl start "$service"
        fi
    done < "$STATE_FILE"
    rm -f "$STATE_FILE"
else
    echo "No saved services to restart." >> /tmp/gamemode-hooks.log
fi
# Restore fixed 240Hz for desktop to prevent VRR brightness flickering
echo "$(date): Disabling VRR (restoring fixed refresh rate)..." >> /tmp/gamemode-hooks.log
kscreen-doctor output.DP-2.vrrpolicy.never >> /tmp/gamemode-hooks.log 2>&1
