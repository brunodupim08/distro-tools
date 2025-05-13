#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset


################### MODIFICATION BELOW THIS LINE ###################
# Use is command line to get the list of installed flatpaks
# flatpak list --app --columns=application

# Exemple:
# apps=(
# org.mozilla.firefox
# )

apps=(

)

################### NO MODIFICATION BELOW THIS LINE ###################

if [[ $EUID -eq 0 ]]; then
    echo -e "\nYou are running this script as ROOT.\n"
    read -p "Do you want to proceed with Flatpak installations? (y/n): " choice
    case "$choice" in 
        y|Y|"" ) echo -e "\nInstallation...";;
        n|N ) echo "Exiting..."; exit 0;;
        * ) echo "Invalid input. Exiting..."; exit 1;;
    esac
fi

if [ ${#apps[@]} -eq 0 ]; then
    echo "    No Flatpaks to install."
    echo "    Check 'flatpaks_install .sh' 'apps=()' array."
    echo "Exiting..."
    exit 1
fi

echo -e "\n==== Install Flatpaks ====="
for app in "${apps[@]}"; do
    flatpak install "$app" -y
done

echo -e "\n==== Update Flatpaks ====="
flatpak update -y

echo -e "\n==== Clean unused ====="
flatpak uninstall --unused -y

exit 0