#!/bin/bash

set_git_hooks() {
    info "Setting up Git hooks..."
    git config core.hooksPath "$INSTALL_DIR/hooks"
    success "Git hooks configured successfully"
}

# Source utility functions
source "./utils.sh"

info "Starting profile update..."

# Run installation scripts
info "Updating Homebrew packages..."
bash "update/brew.sh"

info "Installing missing fonts..."
bash "update/fonts.sh"

info "Updating zsh configuration..."
bash "update/zsh.sh"

set_git_hooks

echo ""
success "🎉 Profile updated successfully!"
