#!/bin/sh

# Get the global Git email
git_email=$(git config --global user.email)

# Check if the email is set
if [ -z "$git_email" ]; then
    echo "Global Git email is not set."
    exit 1
fi

ssh-keygen -t ed25519 -C "$git_email"

ssh-add ~/.ssh/id_ed25519

# Check if clip.exe is available
if command -v clip.exe >/dev/null 2>&1; then
    clipboard_cmd="clip.exe"
else
    # Check if clip is available
    if command -v clip >/dev/null 2>&1; then
        clipboard_cmd="clip"
    else
        echo "Clipboard command not found (neither clip.exe nor clip)."
        exit 1
    fi
fi

# Use the appropriate clipboard command
if [ "$clipboard_cmd" = "clip.exe" ]; then
    "$clipboard_cmd" < ~/.ssh/"id_ed25519.pub"
else
    "$clipboard_cmd" ~/.ssh/"id_ed25519.pub"
fi

echo "Key copied, add to github"
