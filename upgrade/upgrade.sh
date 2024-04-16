#!/bin/bash
# Exit on error
set -e

# Initialize TAG variable
TAG=""

# Parse command-line options
while getopts "t:" opt; do
  case $opt in
    t) TAG=$OPTARG ;;
    \?) echo "Invalid option: -$OPTARG" >&2
        echo "Usage: $0 -t <tag>"
        exit 1 ;;
  esac
done

# Check if TAG was provided
if [ -z "$TAG" ]; then
  echo "Error: Tag not specified."
  echo "Usage: $0 -t <tag>"
  exit 1
fi

# Change directory
cd jito-solana

# Pull the latest changes from the repository
git pull

# Checkout the specified tag
git checkout tags/$TAG

# Update and initialize submodules recursively
git submodule update --init --recursive

# Capture the current commit hash and run the installation script
CI_COMMIT=$(git rev-parse HEAD)
echo "Current commit hash: $CI_COMMIT"

# Execute the installation script
scripts/cargo-install-all.sh --validator-only ~/.local/share/solana/install/releases/"$TAG"
echo "Installation completed successfully for TAG: $TAG at commit: $CI_COMMIT"
