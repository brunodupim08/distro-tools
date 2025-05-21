#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset


################### MODIFICATION BELOW THIS LINE ###################

install_apps=true
remove_apps=true
update_system=true
clean_system=true

apps_install=(
gnome-tweaks
)

apps_remove=(
firefox
gnome-abrt
gnome-calendar
gnome-characters
gnome-contacts
gnome-clocks
gnome-logs
gnome-maps
gnome-system-monitor
gnome-weather
hplip-gui
libreoffice\*
rhythmbox
simple-scan
totem
)

################### NO MODIFICATION BELOW THIS LINE ###################

if [[ $EUID -ne 0 ]]; then
    echo -e "\nThis script must be run as root.\n"
    exit 1
fi

if [[ $install_apps == true ]]; then
    echo "==== Install ===="
    for app in "${apps_install[@]}"; do
        dnf install "$app" -y
    done
    echo ""
fi

if [[ $remove_apps == true ]]; then
    echo "==== Remove ===="
    for app in "${apps_remove[@]}"; do
        dnf remove "$app" -y
    done
    echo ""
fi

if [[ $update_system == true ]]; then
    dnf update -y
fi

if [[ $clean_system == true ]]; then
    dnf autoremove -y
fi

exit 0