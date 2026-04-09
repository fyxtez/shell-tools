# Tauri App Install & Launcher Setup (Linux)

## Goal
Run your Tauri app like a normal desktop app:
- Press **Super (Windows key)**
- Search app name
- Launch it

---

## 1. Build Release

```bash
cargo tauri build
```

Output location:

```
src-tauri/target/release/bundle/
```

---

## 2. Install the App (.deb)

Go to the `.deb` folder:

```bash
cd src-tauri/target/release/bundle/deb
```

Install:

```bash
sudo dpkg -i "Discipline OS_0.1.0_amd64.deb"
```

If dependency errors appear:

```bash
sudo apt -f install
```

---

## 3. Launch the App

- Press **Super (Windows key)**
- Type: `Discipline`
- Launch the app

---

## 4. If App Does NOT Appear

Run:

```bash
update-desktop-database ~/.local/share/applications
```

Or:
- Log out
- Log back in

---

## 5. Fix App Name (IMPORTANT)

Edit:

```
src-tauri/tauri.conf.json
```

Set clean name (no spaces preferred):

```json
{
  "productName": "DisciplineOS",
  "identifier": "com.nikola.disciplineos"
}
```

Rebuild:

```bash
cargo tauri build
```

Reinstall `.deb`.

---

## 6. Verify Launcher Installed

```bash
find /usr/share/applications -iname "*discipline*"
```

---

## 7. (Optional) Manual Launcher

If needed, create:

```bash
~/.local/share/applications/discipline.desktop
```

Example:

```ini
[Desktop Entry]
Type=Application
Name=DisciplineOS
Exec=/path/to/your/app
Icon=discipline
Terminal=false
Categories=Utility;
```

---

## Notes

- `.AppImage` = portable (no install)
- `.deb` = proper system install (recommended)
- Launcher visibility depends on `.desktop` file

---

## TLDR

```bash
cargo tauri build
cd bundle/deb
sudo dpkg -i *.deb
```

→ Press Super → search app → run
