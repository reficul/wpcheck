#!/bin/bash
clear

#COLORS
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

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
                                if [ "$status" == "insecure" ]; then
                                        printf "%-20s | %-10s | %-10s\n" "$d" "$ver" "${RED}$status${NORMAL}"
                                elif [ "$status" == "latest" ]; then
                                        printf "%-20s | %-10s | %-10s\n" "$d" "$ver" "${GREEN}$status${NORMAL}"
                                else
                                    	printf "%-20s | %-10s | %-10s\n" "$d" "$ver" "$status"
                                fi
                        fi
                fi
        done

fi



