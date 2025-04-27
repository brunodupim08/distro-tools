#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset

apps_remove=(
firefox
gnome-abrt
gnome-calendar
gnome-contacts
gnome-clocks
gnome-logs
gnome-maps
gnome-system-monitor
gnome-weather
hplip-gui
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


function update(){
    dnf update -y
}


function clean() {
    dnf autoremove -y
}


function main(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "\nThis script must be run as root.\n"
        exit 1
    fi

    remove_apps
    install_apps
    update
    clean
}

main
