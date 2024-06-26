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
# by NextProgram (2024) 
# ----------------------------------------------------- 


# Set the directory where your wallpapers are stored
wallpaper_dir="$HOME/Repositories/wallpapers/catppuccin"

# Set the interval in minutes to change the wallpaper
interval=1

# Function to set a random wallpaper
set_random_wallpaper() {
    # Get a random wallpaper file from the directory
    wallpaper_file=$(ls "$wallpaper_dir" | shuf -n 1)

    # Set the wallpaper using swww
    swww img "$wallpaper_dir/$wallpaper_file" --transition-type=blend --transition-dur=1.0
}

# Call the set_random_wallpaper function initially
set_random_wallpaper

# Run the set_random_wallpaper function repeatedly at the specified interval
while true; do
    sleep "$((interval * 60))"
    set_random_wallpaper
done