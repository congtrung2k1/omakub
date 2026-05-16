#!/bin/bash

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub is for fresh Kali Linux 2025.1+ GNOME installations only!"
echo "   (For installing from a local checkout instead of cloning, use setup-local.sh.)"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

# Set OMAKUB_REPO to your own fork (e.g. https://github.com/youruser/omakub.git) if you forked.
OMAKUB_REPO="${OMAKUB_REPO:-https://github.com/basecamp/omakub.git}"

echo "Cloning Omakub from $OMAKUB_REPO..."
rm -rf ~/.local/share/omakub
git clone "$OMAKUB_REPO" ~/.local/share/omakub >/dev/null
if [[ $OMAKUB_REF != "master" ]]; then
	cd ~/.local/share/omakub
	git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
