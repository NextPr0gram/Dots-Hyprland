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
# -------------------------------------------------------------

# Get the current volume
current_volume=$(pamixer --get-volume)

# Determine the action (increase or decrease)
action=$1

# Adjust the volume
if [ "$action" == "increase" ]; then
    new_volume=$(( (current_volume + 5) / 5 * 5 ))
elif [ "$action" == "decrease" ]; then
    new_volume=$(( (current_volume - 4) / 5 * 5 ))
fi

# Set the new volume
pamixer --set-volume $new_volume
