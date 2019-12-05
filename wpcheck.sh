#!/bin/bash
clear

read -r -p "Are you sure you want to check all wordpress installed on server? [y/N] " response
ucheck=http://api.wordpress.org/core/stable-check/1.0/
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        printf '%s\n' '---------------------------------------------'
        printf "%-20s | %-10s | %-10s\n" "User" "Version" "Status"
        printf '%s\n' '---------------------------------------------'
        for d in /home/*; do
                if [ -d "$d" ]; then
                        if [ -f "$d/public_html/wp-config.php" ]; then
                                ver='"'$(wp core version --path=$d/public_html --allow-root)'"'
                                status=$(curl -s "$ucheck" | egrep -m 1 "$ver" | awk -F '"' '{ print $4 }')
                                printf "%-20s | %-10s | %-10s\n" "$d" "$ver" "$status"
                        fi
                fi
        done

fi



