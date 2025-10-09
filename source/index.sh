#!/bin/bash
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"

# To suppress last login messages
[[ ! -f ~/.hushlogin ]] && touch ~/.hushlogin

source "$DIR/alias.sh"
source "$DIR/zsh.sh"
source "$DIR/devtools.sh"