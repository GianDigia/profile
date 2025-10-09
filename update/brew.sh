#!/bin/bash

# Source utility functions
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"
source "$DIR/../utils.sh"

if ! command_exists brew; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for the current session
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

if ! command_exists mise; then
    brew install mise
fi

if ! command_exists eza; then
    brew install eza
fi

if ! command_exists bat; then
    brew install bat
fi

if ! command_exists fzf; then
    brew install fzf
fi

if ! command_exists fc-list; then
    brew install fontconfig
fi

if ! command_exists lazygit; then
    brew install lazygit
fi

if [ ! -d /opt/homebrew/Caskroom/iterm2 ]; then
    brew install --cask iterm2
fi

if [ ! -d /opt/homebrew/Caskroom/visual-studio-code ]; then
    brew install --cask visual-studio-code
fi