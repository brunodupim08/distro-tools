#!/usr/bin/env bash

# POSIX
#set -o xtrace
set -o errexit
set -o nounset


# flatpak list --app --columns=application
apps=(
com.bitwarden.desktop
com.discordapp.Discord
com.github.neithern.g4music
com.github.taiko2k.avvie
com.github.tchx84.Flatseal
com.github.unrud.VideoDownloader
com.github.wwmm.easyeffects
com.mattjakeman.ExtensionManager
com.protonvpn.www
fr.romainvigier.MetadataCleaner
io.github.flattool.Warehouse
io.github.seadve.Mousai
io.gitlab.adhami3310.Converter
io.gitlab.librewolf-community
io.podman_desktop.PodmanDesktop
md.obsidian.Obsidian
net.nokyan.Resources
net.pcsx2.PCSX2
org.gnome.DejaDup
org.inkscape.Inkscape
org.jellyfin.JellyfinServer
org.keepassxc.KeePassXC
org.libretro.RetroArch
org.qbittorrent.qBittorrent
org.telegram.desktop
org.videolan.VLC
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
}

main