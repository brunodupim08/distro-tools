#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset

################### MODIFICATION BELOW THIS LINE ###################

# Use is command line to get the list of installed flatpaks
# flatpak list --app --columns=application
#
# Exemple:
# apps=(
# org.mozilla.firefox
# )
apps=(

)

################### NO MODIFICATION BELOW THIS LINE ###################
function install(){
    echo -e "\n==== Install Flatpaks ====="
    for app in "${apps[@]}"; do
        flatpak install "$app" -y
    done
}


function update(){
    echo -e "\n==== Update Flatpaks ====="
    flatpak update -y
}


function clean(){
    echo -e "\n==== Clean ====="
    flatpak uninstall --unused
}


function main(){

    if [[ $EUID -eq 0 ]]; then
        read -p "You are running this script as ROOT. Do you want to proceed with Flatpak installations? (y/n): " choice
        case "$choice" in 
            y|Y ) echo "Proceeding with installation...";;
            n|N ) echo "Exiting..."; exit 0;;
            * ) echo "Invalid input. Exiting..."; exit 1;;
        esac
    fi

    if [ ${#apps[@]} -eq 0 ]; then
        echo "No Flatpaks to install. Exiting..."
        exit 0
    fi

    install
    update
    clean
}

main
