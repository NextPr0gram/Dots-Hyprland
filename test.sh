#!/bin/bash

# Get all files and directories within the config directory
config_dirs=$(find "config" -mindepth 1 -maxdepth 1)

# Iterate through each item and print the path
for ITEM in $CONFIG_ITEMS; {
    echo "$ITEM"
}