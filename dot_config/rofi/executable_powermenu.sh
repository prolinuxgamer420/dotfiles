#!/bin/bash

options=" Lock\n󰗽 Logout\n󰜉 Reboot\n󰐥 Shutdown"

choice=$(echo -e "$options" | rofi -dmenu -i -p "Power")

case "$choice" in
    " Lock")
        i3lock
        ;;
    "󰗽 Logout")
        i3-msg exit
        ;;
    "󰜉 Reboot")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
esac

