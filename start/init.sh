#!/bin/bash
# Exit script on error
set -e

# Initialize the TAG variable
TAG=""

# Parse command-line options
while getopts "t:" opt; do
  case $opt in
    t) TAG=$OPTARG ;;
    \?) echo "Usage: cmd [-t tag]"
        exit 1 ;;
  esac
done

# Check if TAG was provided
if [ -z "$TAG" ]; then
  echo "Error: Tag not specified."
  echo "Usage: $0 -t <tag>"
  exit 1
fi

# Clone the repository and initialize submodules
git clone --recurse-submodules https://github.com/jito-foundation/jito-solana.git
cd jito-solana

# Checkout the specified tag and update submodules
git checkout tags/$TAG
git submodule update --init --recursive

# Get the current commit hash
CI_COMMIT=$(git rev-parse HEAD)

# Run the installation script with the correct path; ensure the path exists or is created
INSTALL_PATH="$HOME/.local/share/solana/install/releases/$TAG"
mkdir -p "$INSTALL_PATH"
scripts/cargo-install-all.sh --validator-only "$INSTALL_PATH"

# Notify of successful installation
echo "Installation completed successfully at commit $CI_COMMIT, using tag $TAG in path $INSTALL_PATH."
