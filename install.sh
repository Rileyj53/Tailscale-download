#!/bin/bash

# Define your Tailscale auth key and exit node IP or name
TAILSCALE_AUTH_KEY="<AUTHKEY>"
EXIT_NODE="<IP>"

# Install Homebrew if it's not installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add Homebrew to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Tailscale using Homebrew
echo "Installing Tailscale..."
brew install --cask tailscale

# Start Tailscale GUI
echo "Opening Tailscale GUI..."
open -a Tailscale

# Wait for Tailscale GUI to launch
sleep 5

# Authenticate with Tailscale using the auth key
echo "Authenticating with Tailscale using auth key..."
sudo tailscale up --authkey $TAILSCALE_AUTH_KEY

# Connect to the specified exit node
echo "Connecting to exit node $EXIT_NODE..."
sudo tailscale up --exit-node $EXIT_NODE

echo "Tailscale installation, authentication, and exit node connection complete."
