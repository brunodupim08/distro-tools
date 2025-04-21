#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset


# flatpak list --app --columns=application
apps=(

)


function main(){
    if [[ $EUID -eq 0 ]]; then
        read -p "You are running this script as ROOT. Do you want to proceed with Flatpak installations? (y/n): " choice
        case "$choice" in 
            y|Y ) echo "Proceeding with installation...";;
            n|N ) echo "Exiting..."; exit 0;;
            * ) echo "Invalid input. Exiting..."; exit 1;;
        esac
    fi

    echo "==== Install Flatpaks ====="
    for app in "${apps[@]}"; do
        flatpak install "$app" -y
    done
    echo ""
    flatpak update -y
    echo ""
}

main
