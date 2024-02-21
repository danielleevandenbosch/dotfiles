#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print messages with color
echo_color() {
    local color=$1 text=$2
    echo -e "${color}${text}${NC}"
}

# Define helper function for creating directories and symlinks
create_symlink() {
    local source=$1
    local target=$2

    # Ensure the target directory exists
    local target_dir=$(dirname "$target")
    mkdir -p "$target_dir"

    # Check if the target file or symlink already exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        # Optionally backup the existing target
        echo_color $YELLOW "$target already exists."
        read -p "Do you want to backup and replace it? (y/n) " choice
        case "$choice" in 
          y|Y )
            echo_color $YELLOW "Backing up and replacing $target"
            mv "$target" "${target}.backup"
            ;;
          * )
            echo_color $GREEN "Skipping $target"
            return
            ;;
        esac
    fi

    # Create the symlink
    ln -s "$source" "$target"
    echo_color $GREEN "Created symlink for $source -> $target"
}

# Base directory for dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# Create symlinks
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"

echo_color $GREEN "Dotfiles installation completed."


