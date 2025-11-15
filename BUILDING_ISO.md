# 💿 Building GhostShift OS ISO Image

## Prerequisites

### For WSL/Linux:
```bash
sudo apt-get update
sudo apt-get install -y build-essential cmake ninja-build qemu-system-x86 \
    g++-multilib libgmp-dev libmpfr-dev libmpc-dev texinfo git curl \
    unzip ccache grub-pc-bin xorriso
```

### For Windows (using WSL):
1. Install WSL: `wsl --install`
2. Restart your computer
3. Open WSL and install dependencies (see above)

## Building the ISO

### Option 1: Using the Build Script (Recommended)

#### On WSL/Linux:
```bash
chmod +x build_ghostshift_iso.sh
./build_ghostshift_iso.sh
```

#### On Windows (PowerShell):
```powershell
.\build_ghostshift_iso.ps1
```

This will:
1. Build the cross-compiler toolchain (first time only, ~30-60 minutes)
2. Build GhostShift OS (~10-20 minutes)
3. Create a bootable ISO image

### Option 2: Manual Build

```bash
# 1. Build toolchain (first time only)
Meta/serenity.sh rebuild-toolchain

# 2. Build the OS
Meta/serenity.sh build

# 3. The disk image is created at: Build/x86_64/_disk_image
# You can use this directly with QEMU or convert to ISO
```

## Using the ISO

### Test in QEMU:
```bash
qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G -enable-kvm
```

### Create Bootable USB (Linux):
```bash
# ⚠️ WARNING: This will erase all data on the USB drive!
# Replace /dev/sdX with your USB device (check with 'lsblk')
sudo dd if=GhostShift-OS.iso of=/dev/sdX bs=4M status=progress
sync
```

### Create Bootable USB (Windows):
Use tools like:
- **Rufus**: https://rufus.ie/
- **Etcher**: https://www.balena.io/etcher/

### Use in VirtualBox:
1. Create new VM
2. Select "Linux" → "Other Linux (64-bit)"
3. Allocate at least 2GB RAM
4. Use the ISO as the boot disk

### Use in VMware:
1. Create new VM
2. Select "I will install the operating system later"
3. Choose "Other Linux 5.x kernel 64-bit"
4. Attach the ISO to the CD/DVD drive

## Build Times (Approximate)

| Component | First Build | Subsequent Builds |
|-----------|-------------|-------------------|
| Toolchain | 30-60 min   | Skip (cached)     |
| OS Build  | 10-20 min   | 2-5 min           |
| ISO Creation | 1-2 min  | 1-2 min           |

**Total first build**: ~45-80 minutes
**Subsequent builds**: ~5-10 minutes

## Troubleshooting

### "Toolchain build failed"
- Make sure you have all dependencies installed
- Check you have at least 10GB free disk space
- Try: `Meta/serenity.sh rebuild-toolchain`

### "Kernel image not found"
- The build may have failed
- Check: `Build/x86_64/Kernel/Kernel` exists
- Try rebuilding: `Meta/serenity.sh build`

### "grub-mkrescue not found"
```bash
sudo apt-get install grub-pc-bin xorriso
```

### Build is very slow
- Enable KVM if on Linux: `sudo apt-get install qemu-kvm`
- Use ccache: `sudo apt-get install ccache`
- Increase CPU cores in WSL settings

## System Requirements

### Minimum:
- 4GB RAM
- 20GB free disk space
- Dual-core CPU

### Recommended:
- 8GB+ RAM
- 30GB+ free disk space
- Quad-core+ CPU
- SSD storage

## Quick Start (TL;DR)

```bash
# Install dependencies
sudo apt-get install build-essential cmake ninja-build qemu-system-x86 \
    grub-pc-bin xorriso ccache

# Build ISO
chmod +x build_ghostshift_iso.sh
./build_ghostshift_iso.sh

# Test it
qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G
```

---

**Note**: The first build will take a while as it compiles the entire toolchain and OS from scratch. Grab a coffee! ☕
