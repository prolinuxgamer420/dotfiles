#!/bin/bash

# Usage: ./vol_control.sh [up|down|mute]

case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
esac

# Get the current volume and mute status for the notification
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -1)
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -Po 'yes|no')

if [ "$is_muted" == "yes" ]; then
    # -h string:x-canonical-private-synchronous:volume replaces the previous notification
    notify-send -h string:x-canonical-private-synchronous:volume -u low "Muted" -i audio-volume-muted
else
    # Show a progress bar in the notification (works in Dunst)
    notify-send -h string:x-canonical-private-synchronous:volume -h int:value:"$volume" -u low "Volume: ${volume}%" -i audio-volume-high
fi
