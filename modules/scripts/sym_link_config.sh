#!/bin/bash

set -eu

# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config_files"

# CONFIG_DIRの存在確認
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Error: Config directory not found: $CONFIG_DIR"
    echo "Current working directory: $(pwd)"
    exit 1
fi

# Function to create symbolic links
create_symlink() {
    local src="$1"
    local dest="$2"

    # Check for existing file or symbolic link
    if [ -e "$dest" ]; then
        if [ -L "$dest" ]; then
            echo "Updating existing symlink: $dest"
            rm "$dest"
        else
            # Backup existing file
            local backup_file
            backup_file="${dest}.backup.$(date +%Y%m%d_%H%M%S)"
            echo "Backing up existing file: $dest -> $backup_file"
            mv "$dest" "$backup_file"
        fi
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"

    # Create symbolic link
    ln -sf "$src" "$dest"
    echo "Created symlink: $dest -> $src"
}

# Traverse through config_files directory
find "$CONFIG_DIR" -type f | while read -r src_file; do
    # Get relative path from config_files
    rel_path="${src_file#"$CONFIG_DIR"/}"
    # Build path under home directory
    dest_file="$HOME/$rel_path"

    create_symlink "$src_file" "$dest_file"
done

echo "Configuration files linking completed."
