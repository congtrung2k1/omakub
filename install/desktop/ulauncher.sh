#!/bin/bash

# ulauncher is in Debian sid / Kali rolling. Fall back to upstream .deb if missing.
if ! sudo apt install -y ulauncher; then
  echo "ulauncher not in apt repo; falling back to upstream GitHub .deb release"
  cd /tmp
  ULAUNCHER_DEB_URL=$(curl -fsSL https://api.github.com/repos/Ulauncher/Ulauncher/releases/latest \
    | grep -oE '"browser_download_url":[[:space:]]*"[^"]+_all\.deb"' \
    | head -n1 | cut -d'"' -f4)
  if [ -n "$ULAUNCHER_DEB_URL" ]; then
    wget -qO ulauncher.deb "$ULAUNCHER_DEB_URL"
    sudo apt install -y ./ulauncher.deb
    rm -f ulauncher.deb
  else
    echo "Could not locate a ulauncher .deb on GitHub; skipping ulauncher install."
    cd - >/dev/null
    return 0 2>/dev/null || exit 0
  fi
  cd - >/dev/null
fi

# Start ulauncher to have it populate config before we overwrite
mkdir -p ~/.config/autostart/
cp ~/.local/share/omakub/configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp ~/.local/share/omakub/configs/ulauncher.json ~/.config/ulauncher/settings.json
