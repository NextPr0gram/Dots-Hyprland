#!/bin/bash
config_dirs=$(find "config" -mindepth 1 -maxdepth 1 -type d)

for dir in $config_dirs; do
    base_dir=$(basename "$dir")
    echo "$base_dir"
done