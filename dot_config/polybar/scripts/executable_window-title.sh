#!/usr/bin/env bash

wid=$(xprop -root _NET_ACTIVE_WINDOW 2>/dev/null | awk '{print $5}')

[[ -z "$wid" || "$wid" == "0x0" ]] && exit 0

xprop -id "$wid" WM_NAME 2>/dev/null | cut -d '"' -f2
