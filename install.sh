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

device=""

while true; do
    echo -e "Select device type / n. of monitors\n"
    echo "1) laptop        2) desktop-dual-monitor"
    read -p "> " device

    if [[ "$device" == "1" || "$device" == "2" ]]; then
        break
    else
        echo "Invalid input."
    fi
done

echo "You entered: $device"

if [[ "$device" == "1" ]]; then
    cat "config/hypr/presets/display/display-laptop.conf" > "config/hypr/display.conf"
    cat "config/hypr/presets/workspace/workspace-laptop.conf" > "config/hypr/workspace.conf"
elif [[ "$device" == "2" ]]; then
    cat "config/hypr/presets/display/display-desktop-dual-monitor.conf" > "config/hypr/display.conf"
    cat "config/hypr/presets/workspace/workspace-desktop-dual-monitor.conf" > "config/hypr/workspace.conf"
fi

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
    paru --noconfirm -S "$package"
done < aur-packages.txt


# Create user directories
xdg-user-dirs-update

# Create symbolic links
config_dirs=$(find "config" -mindepth 1 -maxdepth 1)

for dir in $config_dirs; do
    base_dir=$(basename "$dir")
    target_dir="$HOME/.config/$base_dir"
    
    # Check if the directory exists and delete it if it does
    if [ -d "$target_dir" ] || [ -L "$target_dir" ]; then
        echo "Directory or symlink $target_dir exists. Deleting it..."
        rm -rf "$target_dir"
    fi
    
    # Create a symbolic link
    ln -s "$(pwd)/config/$base_dir" "$target_dir"
done

# Add cursor
cp -r "cursor/Bibata-Modern-Ice" "$HOME/.local/share/icons"
# ZSH settings
cp -r ".zshrc" "$HOME"

# Change shell to zsh
chsh -s /usr/bin/zsh 

echo "Installation complete! Please reboot now"
