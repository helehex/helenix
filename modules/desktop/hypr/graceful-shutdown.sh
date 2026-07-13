#!/bin/bash

hyprctl clients -j \
| jq -r 'map(select(.class == "brave-browser") | {(.title): .workspace.name}) | add' \
> ~/.config/BraveSoftware/Brave-Browser/workspaces.json

pkill brave
sleep 1
