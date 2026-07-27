#!/bin/bash

BROWSERS=$(
    hyprctl clients -j |
    jq '
        map(select(.class == "brave-browser")
        | {(.title): .workspace.id})
        | add
        | select(. != null)
    '
)

if [[ $BROWSERS ]]; then
printf '%s\n' "$BROWSERS" > ~/.config/BraveSoftware/Brave-Browser/workspaces.json
fi

if [[ "$1" == "-s" ]]; then
    systemctl poweroff
elif [[ "$1" == "-r" ]]; then
    systemctl reboot
elif [[ "$1" == "-l" ]]; then
    hyprctl dispatch 'hl.dsp.exit()'
fi
