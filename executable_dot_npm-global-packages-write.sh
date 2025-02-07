#!/usr/bin/env bash

# Ensure compatibility with both Bash and Zsh
set -euo pipefail

# Get the global npm root directory
GLOBAL_NPM_ROOT="$(npm root -g)"

# Define the output file
OUTPUT_FILE="$HOME/.npm-global-packages.conf"

# Ensure the file is created or overwritten
> "$OUTPUT_FILE"

# List installed global packages (excluding scoped packages) and write to the file
ls "$GLOBAL_NPM_ROOT" | grep -v '^@' | sed '/^$/d' > "$OUTPUT_FILE"

# Handle scoped packages separately (list contents of each scoped directory)
for scope in $(ls "$GLOBAL_NPM_ROOT" | grep '^@'); do
  for package in "$GLOBAL_NPM_ROOT/$scope"/*; do
    echo "${scope}/$(basename "$package")" >> "$OUTPUT_FILE"
  done
done

# Remove any trailing blank lines
sed -i '' -e '${/^$/d;}' "$OUTPUT_FILE"

# Print message to indicate success
echo "Global npm packages saved to $OUTPUT_FILE"