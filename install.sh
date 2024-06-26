#!/bin/bash
#
# _   _           _  ______                                    
#| \ | |         | | | ___ \                                   
#|  \| | _____  _| |_| |_/ / __ ___   __ _ _ __ __ _ _ __ ___  
#| . ` |/ _ \ \/ / __|  __/ '__/ _ \ / _` | '__/ _` | '_ ` _ \ 
#| |\  |  __/>  <| |_| |  | | | (_) | (_| | | | (_| | | | | | |
#\_| \_/\___/_/\_\\__\_|  |_|  \___/ \__, |_|  \__,_|_| |_| |_|
#                                     __/ |                    
#                                    |___/                     
#         
# Author: NextProgram (2024) 
# ----------------------------------------------------- 

dots="$HOME/Dots-Hyprland"

# Function to handle errors
handle_error() {
    echo "Error on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR


# Installing Arch and AUR packages
echo "Updating system and installing base-devel package group"
sudo pacman -Syu --needed base-devel


echo "Installing Arch packages from $dots/arch-packages.txt"
if [[ -f "$dots/arch-packages.txt" ]]; then
    sudo pacman -S - < "$dots/arch-packages.txt"
else
    echo "File $dots/arch-packages.txt not found."
    exit 1
fi

echo "Installing paru"
if [[ ! -d "paru" ]]; then
    git clone https://aur.archlinux.org/paru.git
else
    echo "Directory paru already exists. Skipping clone."
fi

cd paru
makepkg -si
cd ..

echo "Installing AUR packages from $dots/aur-packages.txt"
if [[ -f "$dots/aur-packages.txt" ]]; then
    paru -S - < "$dots/aur-packages.txt"
else
    echo "File $dots/aur-packages.txt not found."
    exit 1
fi

# Create user directories
xdg-user-dirs-update

# Creating symbolic links
config_dirs=(
    "ags"
    "cava"
    "fastfetch"
    "fontconfig"
    "gtk-3.0"
    "gtk-4.0"
    "hypr"
    "kitty"
    "nwg-look"
    "rofi"
    "swww"
    "xsettingsd"
)

for dir in "${config_dirs[@]}"; do
    ln -s "$dots/$dir" "$HOME/.config/$dir"
done

echo "Installation complete! Please reboot now"