# 🚀 GhostShift OS - Quick Start Guide

## Step 1: Install WSL (Windows Users)

```powershell
wsl --install
```

Restart your computer after installation.

## Step 2: Install Dependencies (in WSL)

Open WSL and run:

```bash
sudo apt-get update
sudo apt-get install -y build-essential cmake ninja-build qemu-system-x86 \
    g++-multilib libgmp-dev libmpfr-dev libmpc-dev texinfo git curl \
    unzip ccache grub-pc-bin xorriso
```

## Step 3: Add Your Logo (Optional)

Copy your GhostShift logo:

```powershell
# In Windows PowerShell:
Copy-Item "your-logo.png" -Destination "Base\res\wallpapers\ghostshift.png"
```

## Step 4: Build the ISO

### Option A: Windows PowerShell
```powershell
.\build_ghostshift_iso.ps1
```

### Option B: WSL/Linux
```bash
chmod +x build_ghostshift_iso.sh
./build_ghostshift_iso.sh
```

⏱️ **First build takes 45-80 minutes** (toolchain compilation)

## Step 5: Test Your OS

```bash
qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G -enable-kvm
```

## 🎉 That's It!

Your GhostShift OS ISO is ready at: `GhostShift-OS.iso`

---

## What You Get:

✅ Bootable ISO image  
✅ Custom GhostShift branding  
✅ Neon green theme  
✅ Your logo as wallpaper  
✅ Full OS with GUI  

## Next Steps:

- **Burn to USB**: Use Rufus or Etcher
- **Run in VM**: VirtualBox, VMware, or QEMU
- **Customize**: Edit files in `Base/` and rebuild

## Need Help?

Check these files:
- `BUILDING_ISO.md` - Detailed build instructions
- `SETUP_GHOSTSHIFT_BACKGROUND.md` - Theme customization
- `BRANDING_UPDATE_COMPLETE.md` - What was changed

---

**Made with 💚 by Ayushman Bosu Roy**
