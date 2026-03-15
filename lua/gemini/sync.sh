#!/usr/bin/env bash

# This script updates the devglow theme inside ~/.gemini/settings.json
# using the devglow.json file in this directory as the source of truth.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME_FILE="$SCRIPT_DIR/devglow.json"
SETTINGS_FILE="$HOME/.gemini/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
	echo "Error: $SETTINGS_FILE not found."
	exit 1
fi

if ! command -v jq &>/dev/null; then
	echo "Error: jq is required but not installed."
	exit 1
fi

# Use jq to read the devglow.json and inject it into settings.json
jq '.ui.customThemes.devglow = input' "$SETTINGS_FILE" "$THEME_FILE" >"$SETTINGS_FILE.tmp" &&
	mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

echo "✅ Successfully synced devglow theme to ~/.gemini/settings.json"
