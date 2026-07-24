#!/bin/bash

BROWSERS=$(
    hyprctl clients -j |
    jq '
        map(select(.class == "brave-browser") | {(.title): .workspace.name})
        | add
        | select(. != null)
    '
)

if [[ $BROWSERS ]]; then
printf '%s\n' "$BROWSERS" > ~/.config/BraveSoftware/Brave-Browser/workspaces.json
fi

pkill brave
