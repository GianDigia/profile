#!/bin/bash

# Profile Configuration Installer
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/GianDigia/profile/main/install.sh)"

# Colors for output (needed before utils.sh is available)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Enable strict mode to catch errors early and fail early:
# -e: Exit if any command fails (non-zero exit code)
# -u: Exit if we try to use an undefined variable
# -o Pipefail: Make sure pipe errors are not hidden
set -euo pipefail

# Configuration
REPO_URL="git@github.com:giandigia/profile.git"
INSTALL_DIR="$HOME/.config/profile"
BACKUP_DIR="$HOME/.config/profile.backup.$(date +%Y%m%d_%H%M%S)"

# Minimal functions needed before cloning
command_exists() { command -v "$1" >/dev/null 2>&1; }
info() { echo -e "\033[0;34m•\033[0m $1"; }
success() { echo -e "\033[0;32m•\033[0m $1"; }
warning() { echo -e "\033[1;33m•\033[0m $1"; }
error() { echo -e "\033[0;31m•\033[0m $1"; }
abort() { error "$1"; exit 1; } 

# Check prerequisites
check_prerequisites() {
    info "Preparing..."
    # Check for Xcode Command Line Tools (which include git)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! xcode-select -p &>/dev/null; then
            warning "Xcode Command Line Tools not found. Installing..."
            xcode-select --install || true
            abort "Please complete the Xcode Command Line Tools installation, then re-run this script."
        fi
    fi

    # Check for git
    if ! command_exists git; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            abort "Git should be available after installing Xcode Command Line Tools. Please ensure installation is complete and re-run this script."
        else
            abort "Git is required. Install Git using your package manager and re-run this script."
        fi
    fi
    
    # Check for curl
    if ! command_exists curl; then
        abort "curl is not installed. Please install curl first."
    fi
    
    success "All prerequisites satisfied"
}

# Backup existing installation
backup_existing() {
    if [[ -d "$INSTALL_DIR" ]]; then
        warning "Existing installation found at $INSTALL_DIR"
        info "Creating backup at $BACKUP_DIR"
        mv "$INSTALL_DIR" "$BACKUP_DIR"
        success "Backup created successfully"
    fi
}

# Clone the repository
clone_repository() {
    info "Cloning Profile repository..."
    
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"
    
    # Clone the repository
    if ! git clone "$REPO_URL" "$INSTALL_DIR"; then
        abort "Failed to clone repository from $REPO_URL"
    fi
    
    # Now source the full utils (overwrites the minimal functions above)
    source "$INSTALL_DIR/utils.sh"
    
    success "Repository cloned successfully to $INSTALL_DIR"
}

# Install profile components
install_profile() {
    info "Installing profile components..."
    
    cd "$INSTALL_DIR"
    
    # Run installation scripts
    info "Installing Homebrew packages..."
    bash "update/brew.sh"
    
    info "Installing fonts..."
    bash "update/fonts.sh"
    
    info "Installing zsh configuration..."
    bash "update/zsh.sh"
    
    info "Installing iTerm2 configuration..."
    bash "install/iterm2.sh"
    
    success "Profile components installed successfully"
}

# Update shell configuration
update_shell_config() {
    info "Updating shell configuration..."
    
    local shell_config=""
    
    # Determine shell configuration file
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_config="$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        shell_config="$HOME/.bashrc"
    else
        warning "Unsupported shell: $SHELL. You may need to manually add the profile to your shell configuration."
        return
    fi
    
    # Check if profile is already sourced
    local source_line="source \"$INSTALL_DIR/source/index.sh\""
       
    if [[ -f "$shell_config" ]]; then
        info "Backing up existing $shell_config to ${shell_config}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$shell_config" "${shell_config}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    info "Writing new $shell_config with profile source line only"
    echo "$source_line" > "$shell_config"
    success "$shell_config replaced with profile source line."
}

set_git_hooks() {
    info "Setting up Git hooks..."
    git config core.hooksPath hooks
    success "Git hooks configured successfully"
}

# Main installation function
main() {
    check_prerequisites
    backup_existing
    clone_repository
    install_profile
    update_shell_config
    set_git_hooks
    
    echo ""
    success "Installation completed successfully"
    info "This profile is now installed at: $INSTALL_DIR"
    
    if [[ -d "$BACKUP_DIR" ]]; then
        info "Previous installation backed up to: $BACKUP_DIR"
    fi
}

# Run main function
main "$@"
