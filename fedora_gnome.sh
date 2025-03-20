#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset

apps_remove=(
firefox
gnome-calendar
gnome-clocks
gnome-maps
gnome-abrt
gnome-logs
gnome-weather
gnome-contacts
libreoffice\*
rhythmbox
totem
)

apps_install=(
gnome-tweaks
)

function remove_apps(){
    echo "==== Remove ===="
    for app in "${apps_remove[@]}"; do
        dnf remove "$app" -y
    done
    echo ""
}


function install_apps(){
    echo "==== Install ===="
    for app in "${apps_install[@]}"; do
        dnf install "$app" -y
    done
    echo ""
}


function main(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "\nThis script must be run as root.\n"
        exit 1
    fi

    remove_apps
    install_apps
}

main
