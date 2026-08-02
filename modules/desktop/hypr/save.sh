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
    pkill brave
    systemctl poweroff
elif [[ "$1" == "-r" ]]; then
    pkill brave
    systemctl reboot
elif [[ "$1" == "-l" ]]; then
    pkill brave
    hyprctl dispatch 'hl.dsp.exit()'
fi
