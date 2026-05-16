#!/bin/bash

if [ ! -f /etc/apt/keyrings/packages.microsoft.gpg ] || [ ! -f /usr/share/keyrings/microsoft.gpg ]; then
  [ -f /etc/apt/keyrings/packages.microsoft.gpg ] && sudo rm /etc/apt/keyrings/packages.microsoft.gpg
  cd /tmp
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
  rm -f packages.microsoft.gpg
  cd -
fi

sudo apt update
sudo apt install -y code

mkdir -p ~/.config/Code/User
cp ~/.local/share/omakub/configs/vscode.json ~/.config/Code/User/settings.json

# Install default supported themes.
#   --disable-telemetry: VS Code's CLI otherwise flushes pending telemetry POSTs
#     to mobile.events.data.microsoft.com on exit. If that endpoint is slow or
#     blocked (privacy DNS, firewalls, offline networks), the install hangs
#     indefinitely. See logs at ~/.config/Code/logs/*/cli.log.
#   timeout: hard ceiling so a network hiccup can never wedge the installer.
#   || true: a failed theme install shouldn't abort the whole omakub run.
timeout 180 code --install-extension catppuccin.catppuccin-vsc --disable-telemetry || \
  echo "Warning: VS Code extension install failed or timed out; continuing."