#!/bin/bash

# Function to check and install a package
install_package() {
    local package_name=$1
    local command_name=${2:-$package_name}  # Use a custom command if specified, default to package name

    # Check if the package is installed
    if ! command -v "$command_name" &> /dev/null; then
        echo "$package_name is not installed. Installing now..."
        
        # Detect package manager and install the package
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y "$package_name"
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y "$package_name"
        elif command -v pacman &> /dev/null; then
            sudo pacman -Sy "$package_name"
        elif command -v brew &> /dev/null; then
            brew install "$package_name"
        else
            echo "Package manager not detected. Please install $package_name manually."
            return 1
        fi

        echo "$package_name installed successfully."
    else
        echo "$package_name is already installed."
    fi
}

# List of packages and their respective command names (if different)
declare -A packages=(
    [i3]=i3
    [picom]=picom
    [rofi]=rofi
    [polybar]=polybar
    [kitty]=kitty
    [thunar]=thunar
    [neovim]=nvim  
    [vim]=vim
    [flameshot]=flameshot
)

# Iterate through each package and install if necessary
package_installer(){
for package in "${!packages[@]}"; do
    install_package "$package" "${packages[$package]}"
done
echo "package installation succhessfull"
return 0
}
option() {
    read -p "Do you want to set the configuration files in their respective places (Default is Y): " option
    option=${option:-Y}  # Set default to "Y" if no input is provided
    
    if [[ "$option" == "y" || "$option" == "Y" ]]; then
         cp -r ./dotfiles/* "$HOME/.config/"
	cp -r ./images/* "$HOME/Pictures" && \
        echo "Files successfully copied!" && return 0
    else
        echo "Task terminated"
        return 1
    fi
}

main() {
	echo "Welome"
	echo "This scripts allows you to setup my configuration and dev enviroment"
	package_installer
	option
}



main
