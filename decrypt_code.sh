#!/usr/bin/env bash
# decrypt_code.sh — decrypt blob.age and extract the ceremony scripts.
#
# Run on the ceremony machine after cloning this repo. Decrypts the
# sibling `blob.age` and extracts `code/` next to it. Read `code/README.md`
# from the top after extraction.
#
# Usage:
#   ./decrypt_code.sh
#
# Requires:
#   - `age` and `tar` on PATH (Tails: `sudo apt install -y age`).
#   - The 1Password "Key Management Encryption Password" entry, which `age`
#     will prompt for once.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ ! -f blob.age ]; then
    echo "error: blob.age not found in $SCRIPT_DIR" >&2
    echo "       this script must live next to blob.age in the" >&2
    echo "       key-management-code repo clone" >&2
    exit 1
fi

age -d blob.age | tar xzf -

echo "Extracted to $SCRIPT_DIR/code"
echo "Next: cd code && cat README.md"
