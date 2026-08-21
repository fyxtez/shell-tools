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
    "*/.next/*" \
    "*/.cache/*" \
    "*/coverage/*" \
    "*/tmp/*" \
    "*/temp/*" \
    "*/src-tauri/gen/*" \
    "*/.env" \
    "*/.env.*" \
    "*/keystore.properties" \
    "*.jks" \
    "*.keystore" \
    "*/zip.sh" \
    "*/LICENCE" \
    "*/LICENSE" \
    "*/SECURITY" \
    "*.zip" \
    "*.db" \
    "*.db-shm" \
    "*.db-wal" \
    "*.sqlite" \
    "*.sqlite3" \
    "*.log" \
    "*/.DS_Store" \
    "*.png" \
    "*.jpg" \
    "*.jpeg" \
    "*.gif" \
    "*.webp" \
    "*.bmp" \
    "*.tif" \
    "*.tiff" \
    "*.ico" \
    "*.svg" \
    "*.avif" \
    "*.heic" \
    "*.heif"

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
