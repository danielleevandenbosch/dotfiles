#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
DOTFILES_DIR="$HOME/dotfiles"
CSV_FILE_PATH="$DOTFILES_DIR/progs.csv"
USER_NAME=$(logname)
HOME_DIR=$(getent passwd "$USER_NAME" | cut -d: -f6)
# Function to print messages with color
echo_color() {
    local color=$1 text=$2
    echo -e "${color}${text}${NC}"
}


# Function to install applications from a CSV file
install_applications() 
{
    local csv_path=$1
    while IFS=, read -r source name purpose; do
        # Skip lines starting with '#'
        [[ "$source" =~ ^#.*$ ]] && continue

        # Determine the action based on the source field
        if [ -z "$source" ]; then  # Default package manager
            if command -v apt &> /dev/null; then
                echo_color $YELLOW "Installing $name using apt... $purpose"
                sudo apt install -y "$name"
            elif command -v pacman &> /dev/null; then
                echo_color $YELLOW "Installing $name using pacman... $purpose"
                sudo pacman -S --noconfirm "$name"
            else
                echo_color $RED "Unsupported package manager. Skipping $name."
            fi
        elif [ "$source" == "git" ]; then
            IFS=',' read -r url target_dir <<< "$name"
            target_dir=$purpose
            echo_color $YELLOW "Cloning $url into $target_dir... $purpose"
            mkdir -p "$(dirname "$target_dir")"
            git clone "$url" "$target_dir"
        elif [ "$source" == "aur" ]; then
            echo_color $YELLOW "Installing $name from AUR... $purpose"
            # AUR installation logic here (e.g., using yay or another AUR helper)
            yay -S --noconfirm "$name"
        elif [ "$source" == "curl" ]; then
            url="$name"
            target_file="$purpose"
            echo_color $YELLOW "Curling $url to $target_file"
            mkdir -p "$(dirname "$target_file")"
            curl -fLo "$target_file" --create-dirs "$url"
            echo_color $GREEN "Downloaded $target_file from $url"
        else
            echo_color $RED "Unknown source $source for $name. Skipping."
        fi
    done < "$csv_path"
} # End of install_applications function

# Check if the operating system is Debian or Arch based and install applications
if [ -f "$CSV_FILE_PATH" ]; then
    install_applications "$CSV_FILE_PATH"
else
    echo_color $RED "CSV file with applications not found."
fi

# Define helper function for creating directories and symlinks
create_symlink() 
{
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

# Function to set Zsh as the default shell if it exists
set_zsh_default() 
{
    if command -v zsh &> /dev/null; then
        echo_color $YELLOW "Zsh is installed. Do you want to set it as the default shell? (y/n)"
        read -r choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            if chsh -s "$(which zsh)"; then
                echo_color $GREEN "Zsh is now the default shell."
            else
                echo_color $RED "Failed to set Zsh as the default shell."
            fi
        else
            echo_color $GREEN "Not setting Zsh as the default shell."
        fi
    else
        echo_color $YELLOW "Zsh is not installed, skipping."
    fi
}


set_xinitrc_default()
{
    # does the computer have dwm installed?
    echo_color $YELLOW "Do you want to set xinitrc taylored for dwm? (y/n)"
    read -r choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        if [ -f "$HOME/.xinitrc" ]; then
            echo_color $YELLOW "Backing up and replacing $HOME/.xinitrc"
            mv "$HOME/.xinitrc" "$HOME/.xinitrc.backup"
        fi
        create_symlink "$DOTFILES_DIR/.xinitrc" "$HOME/.xinitrc"
    else
        echo_color $GREEN "Not setting Dwm as the default window manager."
    fi
}

set_xprofile_default()
{
    # does the computer have dwm installed?
    echo_color $YELLOW "Do you want to set the dotfiles xprofile taylored for dwm? (y/n)"
    read -r choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        if [ -f "$HOME/.xprofile" ]; then
            echo_color $YELLOW "Backing up and replacing $HOME/.xprofile"
            mv "$HOME/.xprofile" "$HOME/.xprofile.backup"
        fi
        create_symlink "$DOTFILES_DIR/.xprofile" "$HOME/.xprofile"
    else
        echo_color $GREEN "Not setting Dwm as the default window manager."
    fi
}

# Attempt to set Zsh as the default shell (Added before the completion message)
set_zsh_default
set_xinitrc_default
set_xprofile_default

# Create symlinks
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.scimrc" "$HOME/.scimrc"
create_symlink "$DOTFILES_DIR/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"

# Handle init.lua integration
if [ -f "$DOTFILES_DIR/init.lua" ]; then
    create_symlink "$DOTFILES_DIR/init.lua" "$HOME/.config/nvim/init.lua"
    echo_color $GREEN "init.lua has been integrated into Neovim configuration."
else
    echo_color $RED "init.lua file not found in $DOTFILES_DIR. Skipping."
fi



echo_color $GREEN "Dotfiles installation completed."


