# Tauri App Install & Launcher Setup (Linux)

## Goal
Run your Tauri app like a normal desktop app:

- Press **Super (Windows key)**
- Search your app name
- Launch it

---

## Config (EDIT THIS)

```bash
APP_NAME="DisciplineOS"
APP_ID="com.nikola.disciplineos"
BUNDLE_DIR="src-tauri/target/release/bundle/deb"
DEB_PATTERN="*.deb"
```

---

## 1. Set App Name (IMPORTANT)

Edit:

```
src-tauri/tauri.conf.json
```

```json
{
  "productName": "DisciplineOS",
  "identifier": "com.nikola.disciplineos"
}
```

**Rules:**
- No spaces preferred
- Keep name stable
- Use reverse-domain identifier

---

## 2. Build Release

```bash
cargo tauri build
```

---

## 3. Install App

```bash
cd $BUNDLE_DIR
sudo dpkg -i $DEB_PATTERN || sudo apt -f install -y
```

---

## 4. Launch

- Press **Super**
- Type: `DisciplineOS`
- Open app

---

## 5. If App Not Visible

```bash
update-desktop-database ~/.local/share/applications 2>/dev/null || true
sudo update-desktop-database /usr/share/applications 2>/dev/null || true
```

Optional:

```bash
gtk-update-icon-cache ~/.local/share/icons/hicolor 2>/dev/null || true
sudo gtk-update-icon-cache /usr/share/icons/hicolor 2>/dev/null || true
```

If still missing:
- Log out / log in
- Or reboot

---

## 6. Verify Launcher

```bash
find /usr/share/applications ~/.local/share/applications -iname "*discipline*" 2>/dev/null
```

---

## 7. Manual Launcher (Fallback)

```bash
mkdir -p ~/.local/share/applications
nano ~/.local/share/applications/${APP_NAME,,}.desktop
```

```ini
[Desktop Entry]
Type=Application
Version=1.0
Name=DisciplineOS
Exec=/absolute/path/to/app
Icon=disciplineos
Terminal=false
Categories=Utility;
StartupNotify=true
```

```bash
chmod +x ~/.local/share/applications/${APP_NAME,,}.desktop
update-desktop-database ~/.local/share/applications
```

---

## 8. Generic Install Script

```bash
#!/usr/bin/env bash
set -e

APP_NAME="DisciplineOS"
BUNDLE_DIR="src-tauri/target/release/bundle/deb"
DEB_PATTERN="*.deb"

cargo tauri build

cd "$BUNDLE_DIR"
sudo dpkg -i $DEB_PATTERN || sudo apt -f install -y

echo "Installed $APP_NAME"
echo "Press Super and search for: $APP_NAME"
```

---

## Notes

- `.deb` = proper system install
- `.AppImage` = portable (no install)
- Launcher depends on `.desktop` file + cache refresh

---

## TL;DR

```bash
cargo tauri build
cd src-tauri/target/release/bundle/deb
sudo dpkg -i *.deb || sudo apt -f install -y
```

→ Press Super → search app → run
