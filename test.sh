# Create symbolic links
config_dirs=$(find "$(pwd)/config" -mindepth 1 -maxdepth 1)

for dir in $config_dirs; do
    base_dir=$(basename "$dir")
    target_dir="$HOME/.config/$base_dir"
    
    echo "Processing $dir -> $target_dir"
    
    # Create a symbolic link
    ln -s "$dir" "$target_dir" || { echo "Failed to create symbolic link for $base_dir"; exit 1; }
    echo "Symbolic link created: $target_dir -> $dir"
done

