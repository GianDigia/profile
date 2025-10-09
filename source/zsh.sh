#!/bin/bash
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"

# if we're not on zsh
if [ "$(basename -- "$SHELL")" != "zsh" ]; then
    echo "❌ Error: You're not running zsh."
    exit 1
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
    1password
    eza
    fzf
    git
    iterm2
    jsontools
    macos
    rails
    z
    zsh-autosuggestions
)

ZSH_THEME="powerlevel10k/powerlevel10k"

# Load Oh My Zsh
export ZSH="$DIR/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Load fzf shell extensions for zsh
source <(fzf --zsh)

# Load zoxide
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$DIR/.p10k.zsh" ]] || source "$DIR/.p10k.zsh"
