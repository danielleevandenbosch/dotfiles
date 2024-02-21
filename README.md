# Dotfiles Installation Guide

This guide explains how to use the `install.sh` script to set up your dotfiles. The script creates symbolic links for common configuration files like `.bashrc`, `.vimrc`, `.zshrc`, and the Neovim configuration `init.vim`. It ensures that your environment is set up quickly and consistently across different machines.

## Getting Started

1. **Clone your dotfiles repository** (If you fork, this will need to change)

   ```bash
   git clone git@github.com:danielleevandenbosch/dotfiles.git ~/dotfiles
   ```

2. **Navigate to your dotfiles directory**:

   ```bash
   cd ~/dotfiles
   ```

3. **Ensure the script is executable**:

   ```bash
   chmod +x install.sh
   ```

4. **Run the installation script**:

   ```bash
   ./install.sh
   ```

   Follow the on-screen prompts to backup and replace any existing configuration files.

## What the Script Does

- Checks if the target configuration files already exist.
- Prompts you to backup and replace existing files.
- Creates necessary directories if they don't exist (e.g., `~/.config/nvim`).
- Creates symbolic links from your dotfiles repository to your home directory.

## Customizing the Script

Feel free to modify `install.sh` to include additional configuration files or handle more complex setup processes. The script is designed to be straightforward and easy to customize.

## Troubleshooting

- If you encounter permission issues, ensure you have the necessary rights to create symlinks in your home directory.
- For problems with specific configurations not being applied, verify the symbolic links were created correctly with `ls -la ~`.

## Contributing

Contributions to improve the script or add more configurations are welcome. Please submit a pull request or open an issue if you have suggestions or need help.

Thank you for using this dotfiles setup guide!
```
