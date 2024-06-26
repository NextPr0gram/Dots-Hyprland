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

while ! pgrep -x swww-daemon >/dev/null; do
   sleep 1
done

# Set the directory where your wallpapers are stored
wallpaper_dir="$HOME/Pictures/wallpapers"

# Set the interval in minutes to change the wallpaper
interval=1

transition_pos=(
    "top-left"
    "top-right"
    "bottom-left"
    "bottom-right"
    "center"
    "top"
    "bottom"
    "left"
    "right"
)

# Initialize an empty list to track shown wallpapers
shown_wallpapers=()

# Function to set a random wallpaper
set_random_wallpaper() {
    
    wallpaper_files=($(ls "$wallpaper_dir"))

    # Check if all wallpapers have been shown
    if [ ${#shown_wallpapers[@]} -eq ${#wallpaper_files[@]} ]; then
        # Reset the list if all wallpapers have been shown
        shown_wallpapers=()
    fi

    # Find a wallpaper that hasn't been shown yet
    while : ; do
        wallpaper_file=$(ls "$wallpaper_dir" | shuf -n 1)
        if [[ ! " ${shown_wallpapers[@]} " =~ " $wallpaper_file " ]]; then
            shown_wallpapers+=("$wallpaper_file")
            break
        fi
    done
    

    # Get a random transition position
    random_pos=${transition_pos[$((RANDOM % ${#transition_pos[@]}))]}

    # Set the wallpaper using swww
    swww img "$wallpaper_dir/$wallpaper_file" \
        --transition-type outer \
        --transition-duration=5 \
        --transition-fps=60 \
        --transition-pos "$random_pos"
}

# Call the set_random_wallpaper function initially
set_random_wallpaper

# Run the set_random_wallpaper function repeatedly at the specified interval
while true; do
    sleep "$((interval * 10))"
    set_random_wallpaper
done
