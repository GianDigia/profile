#!/bin/bash
DIR="$(dirname "${BASH_SOURCE[0]:-$0}")"

alias cat=bat
alias c=clear
alias remove_nm="find . -type d -name node_modules -exec rm -rf {} +"

# Update all installed tools and configurations
alias update-all='echo "🔄 Updating all tools and configurations..." && \
  echo "📦 Updating Homebrew packages..." && \
  brew update && brew upgrade && \
  echo "🐚 Updating Oh My Zsh..." && \
  (cd ~/.config/profile/source/.oh-my-zsh && git pull) && \
  echo "🔌 Updating zsh plugins..." && \
  (cd ~/.config/profile/source/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull) && \
  echo "🎨 Updating powerlevel10k theme..." && \
  (cd ~/.config/profile/source/.oh-my-zsh/custom/themes/powerlevel10k && git pull) && \
  echo "⚙️  Updating mise..." && \
  mise upgrade && \
  echo "✅ All updates completed!"'

# Export current iTerm2 configuration to profile repository
alias update-iterm2-config='echo "📱 Exporting iTerm2 configuration..." && \
  cp ~/Library/Preferences/com.googlecode.iterm2.plist "$DIR/../com.googlecode.iterm2.plist" && \
  echo "✅ iTerm2 configuration exported to $DIR/../com.googlecode.iterm2.plist"'
