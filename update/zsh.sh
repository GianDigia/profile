#!/bin/bash

# Source utility functions
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"
source "$DIR/../utils.sh"

# if we're not on zsh
if [ "$(basename -- "$SHELL")" != "zsh" ]; then
    abort "You're not running zsh."
fi

# install oh-my-zsh if not installed
SOURCE_ZSH_DIR="$DIR/../source/.oh-my-zsh"
if [[ ! -d "$SOURCE_ZSH_DIR" ]]; then
    info "Installing Oh My Zsh..."

    KEEP_ZSHRC=yes RUNZSH=no ZSH="$SOURCE_ZSH_DIR" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install zsh-autosuggestions if not installed
if [[ ! -d "$SOURCE_ZSH_DIR/custom/plugins/zsh-autosuggestions" ]]; then
    info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$SOURCE_ZSH_DIR/custom/plugins/zsh-autosuggestions"
fi

# install powerlevel10k if not installed
if [[ ! -d "$SOURCE_ZSH_DIR/custom/themes/powerlevel10k" ]]; then
    info "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$SOURCE_ZSH_DIR/custom/themes/powerlevel10k"
fi