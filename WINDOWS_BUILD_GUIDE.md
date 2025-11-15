# 🪟 GhostShift OS - Windows Build Guide

## Step 1: Install WSL (5 minutes)

Open **PowerShell as Administrator** and run:

```powershell
wsl --install
```

**Then restart your computer.**

After restart, WSL will automatically open and ask you to create a username and password.

---

## Step 2: Install Build Tools in WSL (10 minutes)

Open WSL (search "Ubuntu" in Start menu) and run these commands:

```bash
sudo apt-get update
sudo apt-get install -y build-essential cmake ninja-build qemu-system-x86 \
    g++-multilib libgmp-dev libmpfr-dev libmpc-dev texinfo git curl \
    unzip ccache grub-pc-bin xorriso
```

Enter your WSL password when prompted.

---

## Step 3: Navigate to Your Project

In WSL, navigate to your GhostShift OS folder:

```bash
cd /mnt/d/bhai\ placement\ ki\ mahanat/GhostShift\ OS
```

**Tip**: Windows drives are mounted at `/mnt/c/`, `/mnt/d/`, etc.

---

## Step 4: Build the ISO

### Option A: Using PowerShell (Recommended)

Open **PowerShell** (not as admin) in your project folder and run:

```powershell
.\build_ghostshift_iso.ps1
```

### Option B: Using WSL Directly

In WSL, run:

```bash
chmod +x build_ghostshift_iso.sh
./build_ghostshift_iso.sh
```

---

## ⏱️ Build Time

**First Build**: 45-80 minutes
- Toolchain compilation: 30-60 min
- OS compilation: 10-20 min
- ISO creation: 1-2 min

**Subsequent Builds**: 5-10 minutes

---

## Step 5: Test Your ISO

### In QEMU (WSL):
```bash
qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G -enable-kvm
```

### In VirtualBox (Windows):
1. Download VirtualBox: https://www.virtualbox.org/
2. Create new VM → Linux → Other Linux (64-bit)
3. Allocate 2GB+ RAM
4. Use `GhostShift-OS.iso` as boot disk

### Create Bootable USB:
1. Download Rufus: https://rufus.ie/
2. Select your USB drive
3. Select `GhostShift-OS.iso`
4. Click "Start"

---

## 🎯 Quick Commands Reference

### Open WSL:
```powershell
wsl
```

### Navigate to project:
```bash
cd /mnt/d/bhai\ placement\ ki\ mahanat/GhostShift\ OS
```

### Build ISO:
```bash
./build_ghostshift_iso.sh
```

### Test in QEMU:
```bash
qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G
```

---

## 🔧 Troubleshooting

### "wsl: command not found"
- Make sure you're using Windows 10 version 2004+ or Windows 11
- Run: `wsl --install` in PowerShell as Administrator

### "Permission denied" in WSL
```bash
chmod +x build_ghostshift_iso.sh
```

### Build is slow
- Close other applications
- Increase WSL memory in `.wslconfig`:
  ```
  [wsl2]
  memory=4GB
  processors=4
  ```
  Save to: `C:\Users\YourName\.wslconfig`

### "Toolchain build failed"
- Check you have 20GB+ free space
- Try: `Meta/serenity.sh rebuild-toolchain`

---

## 📊 System Requirements

**Minimum:**
- Windows 10 version 2004+ or Windows 11
- 8GB RAM (4GB for WSL)
- 20GB free disk space
- Dual-core CPU

**Recommended:**
- 16GB RAM (8GB for WSL)
- 30GB+ free disk space
- Quad-core+ CPU
- SSD storage

---

## 🎨 Customize Before Building

### Add Your Logo:
```powershell
Copy-Item "your-logo.png" -Destination "Base\res\wallpapers\ghostshift.png"
```

### Change Theme Colors:
Edit: `Base\res\themes\GhostShift.ini`

---

## ✅ What You'll Get

After building, you'll have:
- ✅ `GhostShift-OS.iso` - Bootable ISO image
- ✅ Custom green theme
- ✅ Your logo as wallpaper
- ✅ Full GUI operating system
- ✅ Ready to run on real hardware or VM

---

## 🚀 Quick Start (TL;DR)

```powershell
# 1. Install WSL (restart after)
wsl --install

# 2. In WSL, install dependencies
sudo apt-get update && sudo apt-get install -y build-essential cmake ninja-build qemu-system-x86 g++-multilib libgmp-dev libmpfr-dev libmpc-dev texinfo git curl unzip ccache grub-pc-bin xorriso

# 3. Navigate to project
cd /mnt/d/bhai\ placement\ ki\ mahanat/GhostShift\ OS

# 4. Build ISO
chmod +x build_ghostshift_iso.sh
./build_ghostshift_iso.sh

# 5. Test it
qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G
```

---

**Need help?** Check `BUILDING_ISO.md` for more details.

**Made with 💚 by Ayushman Bosu Roy**
