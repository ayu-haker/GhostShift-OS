# 🎨 Setup GhostShift OS Background

## Quick Setup (3 Steps)

### Step 1: Add Your Logo Image

1. Save your GhostShift logo image as: `Base/res/wallpapers/ghostshift.png`
2. Recommended size: 1920x1080 or 1280x720

### Step 2: Set as Default Wallpaper

Edit or create: `Base/home/anon/.config/WindowServer.ini`

```ini
[Background]
Wallpaper=/res/wallpapers/ghostshift.png
Mode=Fill
Color=#000a05
```

### Step 3: Build and Run

```bash
# In WSL or Linux:
Meta/serenity.sh build
Meta/serenity.sh run
```

---

## Alternative: Change Background Color Only

If you just want the dark green/black background without the image:

Edit `Base/home/anon/.config/WindowServer.ini`:

```ini
[Background]
Color=#000a05
Mode=Fill
```

This will give you the dark background from your logo.

---

## Apply GhostShift Theme (Optional)

I've created a custom theme file at `Base/res/themes/GhostShift.ini` with:
- Neon green accents (#00ff64)
- Dark backgrounds (#000a05, #0a1a0f)
- Green highlights and borders

To use it:
1. Build the OS
2. Run it in QEMU
3. Go to: Settings → Theme → Select "GhostShift"

---

## Manual Wallpaper Setup (In Running OS)

Once GhostShift OS is running:
1. Right-click desktop → Display Settings
2. Click "Browse" next to Wallpaper
3. Navigate to `/res/wallpapers/ghostshift.png`
4. Select display mode (Fill, Center, Stretch, Tile)
5. Click Apply

---

## Current Status

✅ Theme file created: `Base/res/themes/GhostShift.ini`
✅ Setup script created: `set_ghostshift_theme.sh`
✅ Python wallpaper generator: `create_ghostshift_wallpaper.py`

📝 **Next:** Copy your logo to `Base/res/wallpapers/ghostshift.png`
