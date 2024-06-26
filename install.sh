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


# Installing Arch and AUR packages
echo "Updating system and installing base-devel package group"
sudo pacman -Syu --needed base-devel

echo "Installing paru"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

echo "Installing Arch packages from $dots/arch-packages.txt"
sudo pacman -S - < "$dots/arch-packages.txt"

echo "Installing AUR packages from $dots/aur-packages.txt"
paru -S - < "$dots/aur-packages.txt"

# Create user directories
xdg-user-dirs-update


# Creating symbolic links
ln -s $dots/ags ~/.config
ln -s $dots/cava ~/.config
ln -s $dots/fastfetch ~/.config
ln -s $dots/fontconfig ~/.config
ln -s $dots/gtk-3.0 ~/.config
ln -s $dots/gtk-4.0 ~/.config
ln -s $dots/hypr ~/.config
ln -s $dots/kitty ~/.config
ln -s $dots/nwg-look ~/.config
ln -s $dots/rofi ~/.config
ln -s $dots/swww ~/.config
ln -s $dots/xsettingsd ~/.config

echo "Installation complete! Please reboot now"

