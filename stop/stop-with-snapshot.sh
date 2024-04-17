#!/bin/bash

# Script to run Solana Validator with specific options

# Define the ledger directory
LEDGER_DIR="/mnt/ledger"

# Check if the ledger directory exists
if [ ! -d "$LEDGER_DIR" ]; then
    echo "Ledger directory $LEDGER_DIR does not exist."
    exit 1
fi

# Execute the Solana validator command
exec solana-validator --ledger "$LEDGER_DIR" exit --min-idle-time 0