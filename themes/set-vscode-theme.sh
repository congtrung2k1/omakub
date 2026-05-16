#!/bin/bash

if command -v code &>/dev/null; then
  # See install/desktop/app-vscode.sh for why --disable-telemetry + timeout.
  timeout 180 code --install-extension "$VSC_EXTENSION" --disable-telemetry >/dev/null || \
    echo "Warning: VS Code theme extension install failed or timed out; continuing."
  sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" ~/.config/Code/User/settings.json
fi
