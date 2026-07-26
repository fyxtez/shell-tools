#!/usr/bin/env bash

set -euo pipefail

CURRENT_DIR="$(pwd)"
FOLDER_NAME="$(basename "$CURRENT_DIR")"
ZIP_NAME="${FOLDER_NAME}.zip"
ZIP_PATH="${CURRENT_DIR}/${ZIP_NAME}"

rm -f "$ZIP_PATH"

echo "Creating: $ZIP_PATH"

cd "$(dirname "$CURRENT_DIR")"

zip -r "$ZIP_PATH" "$FOLDER_NAME" \
    -x \
    "*/node_modules/*" \
    "*/target/*" \
    "*/dist/*" \
    "*/build/*" \
    "*/.git/*" \
    "*/.idea/*" \
    "*/.vscode/*" \
    "*/.next/*" \
    "*/.cache/*" \
    "*/coverage/*" \
    "*/tmp/*" \
    "*/temp/*" \
    "*/.env" \
    "*/.env.*" \
    "*.zip" \
    "*.log" \
    "*/.DS_Store"

echo
echo "Archive created successfully:"
echo "$ZIP_PATH"

if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$CURRENT_DIR" >/dev/null 2>&1 &
elif command -v gio >/dev/null 2>&1; then
    gio open "$CURRENT_DIR" >/dev/null 2>&1 &
else
    echo "Could not find xdg-open or gio to open the file manager."
fi
