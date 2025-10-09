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

declare -A BREW_INSTALLS=(
    [mise]=mise
    [eza]=eza
    [bat]=bat
    [fzf]=fzf
    [fc-list]=fontconfig
    [lazygit]=lazygit
)

for cmd in "${!BREW_INSTALLS[@]}"; do
    if ! command_exists "$cmd"; then
        info "Installing ${BREW_INSTALLS[$cmd]}"
        brew install "${BREW_INSTALLS[$cmd]}"
    fi
done

declare -A BREW_CASK_INSTALLS=(
    [iterm2]=iterm2
    [code]=visual-studio-code
)

for cmd in "${!BREW_CASK_INSTALLS[@]}"; do
    if ! command_exists "$cmd"; then
        info "Installing ${BREW_CASK_INSTALLS[$cmd]}"
        brew install --cask "${BREW_CASK_INSTALLS[$cmd]}"
    fi
done
