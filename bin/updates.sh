#!/usr/bin/env bash

BAR_ICON=""
ICON=/usr/share/icons/gnome/32x32/apps/system-software-update.png

total() { UPD=$(checkupdates | wc -l) ;}

while true; do
    total
    if hash notify-send &>/dev/null; then
        if (( UPD > 50 )); then
            notify-send -u critical -i $ICON "You really need to update!!" "$UPD New packages"
        elif (( UPD > 25 )); then
            notify-send -u normal -i $ICON "You should update soon" "$UPD New packages"
        elif (( UPD > 2 )); then
            notify-send -u low -i $ICON "$UPD New packages"
        fi
    fi

    while (( UPD > 0 )); do
        if (( UPD == 1 )); then
            echo "$UPD Update"
        elif (( UPD > 1 )); then
            echo "$UPD Updates"
        fi
        sleep 10
        total
    done

    while (( UPD == 0 )); do
        echo $BAR_ICON
        sleep 1800
        total
    done
done
