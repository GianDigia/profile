#!/bin/bash

# Shared utility functions for Profile

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

print() {
    echo -e $1
}

# Logging functions
info() {
    print "${BLUE}[INFO]${NC} $1"
}

success() {
    print "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    print "${YELLOW}[WARNING]${NC} $1"
}

error() {
    print "${RED}[ERROR]${NC} $1"
}

abort() {
    error "$1"
    exit 1
}

# Utility for updating output lines
print_and_update_line() {
    local initial_text="$1"
    local updated_text="$2"
    printf "%s" "$initial_text"
    sleep 1
    printf "\r\033[K%s\n" "$updated_text"
}
