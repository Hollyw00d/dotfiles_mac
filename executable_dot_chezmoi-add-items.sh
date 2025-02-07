#!/usr/bin/env bash

# Ensure compatibility with both Bash and Zsh
set -euo pipefail

# Check if `chezmoi` is installed
if ! command -v chezmoi &> /dev/null; then
  echo "Error: 'chezmoi' command not found. Please install 'chezmoi' Homebrew package before running this script."
  exit 1
fi

# Define an array of file paths
files=(
 "$HOME/.chezmoi-add-items.sh"
 "$HOME/.npm-global-packages-install.sh"
 "$HOME/.npm-global-packages-write.sh"
 "$HOME/.npm-global-packages.conf" 
 "$HOME/.oh-my-zsh/custom/aliases.zsh"
 "$HOME/.tmux.conf"
 "$HOME/.vimrc"
 "$HOME/.zshrc"
 "$HOME/Brewfile"
)

# Loop through each file and add it via chezmoi if it exists
for file in "${files[@]}"; do
 if [[ -f "$file" || -d "$file" ]]; then
  chezmoi add "$file"
 fi
done