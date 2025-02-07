#!/usr/bin/env bash

# Ensure compatibility with both Bash and Zsh
set -euo pipefail

# Define the input file
INPUT_FILE="$HOME/.npm-global-packages.conf"

# Check if the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: $INPUT_FILE does not exist. Please ensure the file is created and contains the list of npm packages to install."
  exit 1
fi

# Check if `node` is installed
if ! command -v node &> /dev/null; then
  echo "Error: 'node' command not found. Please install Node.js before running this script."
  exit 1
fi

# Check if `npm` is installed
if ! command -v npm &> /dev/null; then
  echo "Error: 'npm' command not found. Please install npm before running this script."
  exit 1
fi

# Read the input file line by line and install packages
while IFS= read -r package; do
  # Skip blank lines
  if [[ -z "$package" ]]; then
    continue
  fi

  # Install the package globally
  echo "Installing $package globally..."
  npm install -g "$package"
done < "$INPUT_FILE"

echo -e "\nAll packages from $INPUT_FILE have been installed globally.\n\n"

echo -e "List all global npm packages just installed:\n"

npm list -g --depth=0