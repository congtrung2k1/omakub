#!/bin/bash

# Install Omakub from a local checkout (no GitHub clone).
# Usage: bash /path/to/omakub/setup-local.sh
#
# Most installer scripts assume Omakub lives at ~/.local/share/omakub.
# This script symlinks the current checkout there so those paths resolve.

set -e

# Refuse to run via sudo. Running as root puts every per-user file (pipx envs,
# GNOME extensions, dotfiles, etc.) under /root, and gext cannot reach the
# GNOME Shell session DBus from root's session bus. The installer escalates
# privilege with `sudo` itself when needed.
if [ -n "$SUDO_USER" ] && [ "$EUID" -eq 0 ]; then
  echo "Error: Do not run setup-local.sh with sudo." >&2
  echo "Run as your normal (non-root) user; the installer will sudo when needed." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
TARGET="$HOME/.local/share/omakub"

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub (Kali Linux 2025.1+ GNOME edition)"
echo "   Source checkout: $SCRIPT_DIR"

mkdir -p "$(dirname "$TARGET")"

TARGET_CANON="$(readlink -f "$TARGET" 2>/dev/null || echo "$TARGET")"

if [ "$SCRIPT_DIR" = "$TARGET_CANON" ]; then
  echo "   Project is already at $TARGET; no symlink needed."
elif [ -L "$TARGET" ]; then
  if [ "$TARGET_CANON" = "$SCRIPT_DIR" ]; then
    echo "   $TARGET already linked to this checkout."
  else
    echo "   Repointing existing symlink $TARGET -> $SCRIPT_DIR (was $TARGET_CANON)."
    rm "$TARGET"
    ln -s "$SCRIPT_DIR" "$TARGET"
  fi
elif [ -e "$TARGET" ]; then
  BACKUP="${TARGET}.bak-$(date +%s)"
  echo "   $TARGET exists and is not a symlink; moving aside to $BACKUP."
  mv "$TARGET" "$BACKUP"
  ln -s "$SCRIPT_DIR" "$TARGET"
else
  ln -s "$SCRIPT_DIR" "$TARGET"
  echo "   Created symlink $TARGET -> $SCRIPT_DIR."
fi

echo -e "\nBegin installation (or abort with ctrl+c)..."
sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Installation starting..."
source "$TARGET/install.sh"
