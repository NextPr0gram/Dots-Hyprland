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


echo "Installing Arch packages from arch-packages.txt"
while read -r package; do
    sudo pacman -S --noconfirm "$package"
done < arch-packages.txt


echo "Installing paru"
if [[ ! -d "paru" ]]; then
    git clone https://aur.archlinux.org/paru.git
else
    echo "Directory paru already exists. Skipping clone."
fi

cd paru
makepkg -si
cd ..

echo "Installing AUR packages from aur-packages.txt"
while read -r package; do
    paru -S  "$package"
done < aur-packages.txt


# Create user directories
xdg-user-dirs-update

# Creating symbolic links
config_dirs=$(find "config" -mindepth 1 -maxdepth 1)

for dir in "$config_dirs"; do
    ln -s "$dir" "$HOME/.config/$dir"
done

echo "Installation complete! Please reboot now"