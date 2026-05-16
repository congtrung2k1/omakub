#!/bin/bash

if [ ! -f /etc/os-release ]; then
  echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  echo "Installation stopped."
  exit 1
fi

. /etc/os-release

# Check if running on Kali Linux
if [ "$ID" != "kali" ]; then
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Kali Linux (rolling, 2025.1 or higher recommended)"
  echo "Installation stopped."
  exit 1
fi

# Soft-warn if version looks old (Kali rolling; sort -V handles 2026.1 vs 2025.1)
MIN_VERSION="2025.1"
if [ -n "$VERSION_ID" ] && [ "$(printf '%s\n%s\n' "$MIN_VERSION" "$VERSION_ID" | sort -V | head -n1)" != "$MIN_VERSION" ]; then
  echo "$(tput setaf 3)Warning: Detected $ID $VERSION_ID; $MIN_VERSION or newer is recommended."
  echo "Run 'sudo apt update && sudo apt full-upgrade -y' before continuing if you hit issues."
fi

# Check if running on x86
ARCH=$(uname -m)
if [ "$ARCH" != "x86_64" ] && [ "$ARCH" != "i686" ]; then
  echo "$(tput setaf 1)Error: Unsupported architecture detected"
  echo "Current architecture: $ARCH"
  echo "This installation is only supported on x86 architectures (x86_64 or i686)."
  echo "Installation stopped."
  exit 1
fi
