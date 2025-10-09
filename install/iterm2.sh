#!/bin/bash

# Source utility functions
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"
source "$DIR/../utils.sh"

# iTerm2 configuration file path
ITERM2_CONFIG="$DIR/../com.googlecode.iterm2.plist"
ITERM2_PREFS="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Check if configuration file exists
if [ ! -f "$ITERM2_CONFIG" ]; then
    error "iTerm2 configuration file not found at $ITERM2_CONFIG"
    return 1
fi

# Backup existing preferences if they exist
if [ -f "$ITERM2_PREFS" ]; then
    BACKUP_FILE="$ITERM2_PREFS.backup.$(date +%Y%m%d_%H%M%S)"
    info "Backing up existing iTerm2 preferences to $(basename "$BACKUP_FILE")"
    cp "$ITERM2_PREFS" "$BACKUP_FILE"
fi

# Import the configuration file
info "📱 Importing iTerm2 configuration..."
cp "$ITERM2_CONFIG" "$ITERM2_PREFS"

# Set proper permissions
chmod 600 "$ITERM2_PREFS"

success "✅ iTerm2 configuration imported successfully"