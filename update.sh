#!/bin/bash
set_git_hooks() {
    if [ "$(git config --get core.hooksPath)" != "hooks" ]; then
        info "Setting up Git hooks..."
        git config core.hooksPath "hooks"
        success "Git hooks configured successfully"
    fi
}

# Source utility functions
source "./utils.sh"

# Run installation scripts
bash "update/brew.sh"

bash "update/fonts.sh"

bash "update/zsh.sh"

set_git_hooks

echo ""
success "Profile updated successfully"
