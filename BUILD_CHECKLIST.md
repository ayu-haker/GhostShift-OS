# ✅ GhostShift OS Build Checklist (Windows)

## Before You Start

- [ ] Windows 10 (version 2004+) or Windows 11
- [ ] At least 20GB free disk space
- [ ] At least 8GB RAM
- [ ] Stable internet connection

---

## Step-by-Step Checklist

### 1️⃣ Install WSL
- [ ] Open PowerShell as Administrator
- [ ] Run: `wsl --install`
- [ ] Restart computer
- [ ] Open Ubuntu from Start menu
- [ ] Create username and password

**Time**: 5-10 minutes + restart

---

### 2️⃣ Install Build Tools
- [ ] Open WSL/Ubuntu
- [ ] Copy and paste this command:
```bash
sudo apt-get update && sudo apt-get install -y build-essential cmake ninja-build qemu-system-x86 g++-multilib libgmp-dev libmpfr-dev libmpc-dev texinfo git curl unzip ccache grub-pc-bin xorriso
```
- [ ] Enter your WSL password
- [ ] Wait for installation to complete

**Time**: 10-15 minutes

---

### 3️⃣ Navigate to Project
- [ ] In WSL, run:
```bash
cd /mnt/d/bhai\ placement\ ki\ mahanat/GhostShift\ OS
```
- [ ] Verify you're in the right place: `ls` should show folders like `Kernel`, `Userland`, etc.

**Time**: 1 minute

---

### 4️⃣ (Optional) Add Your Logo
- [ ] Copy your logo image
- [ ] In PowerShell, run:
```powershell
Copy-Item "path\to\your\logo.png" -Destination "Base\res\wallpapers\ghostshift.png"
```

**Time**: 1 minute

---

### 5️⃣ Build the ISO

**Option A - PowerShell (Easier):**
- [ ] Open PowerShell in project folder
- [ ] Run: `.\build_ghostshift_iso.ps1`

**Option B - WSL (Direct):**
- [ ] In WSL, run: `chmod +x build_ghostshift_iso.sh`
- [ ] Run: `./build_ghostshift_iso.sh`

**Time**: 45-80 minutes (first build)

---

### 6️⃣ Test Your OS

**In QEMU (WSL):**
- [ ] Run: `qemu-system-x86_64 -cdrom GhostShift-OS.iso -m 2G`

**In VirtualBox (Windows):**
- [ ] Download and install VirtualBox
- [ ] Create new VM (Linux, Other 64-bit)
- [ ] Allocate 2GB+ RAM
- [ ] Attach `GhostShift-OS.iso` as CD/DVD

**Time**: 5 minutes

---

## ✅ Success Indicators

You'll know it worked when you see:
- ✅ "ISO created successfully!" message
- ✅ `GhostShift-OS.iso` file in your project folder
- ✅ File size around 100-300 MB
- ✅ OS boots in QEMU/VirtualBox with GhostShift branding

---

## 🔴 Common Issues

### Issue: "wsl: command not found"
**Solution**: Update Windows or run `wsl --install` as Administrator

### Issue: "Permission denied"
**Solution**: Run `chmod +x build_ghostshift_iso.sh` in WSL

### Issue: "Toolchain build failed"
**Solution**: 
- Check free disk space (need 20GB+)
- Close other applications
- Try again: `Meta/serenity.sh rebuild-toolchain`

### Issue: Build is very slow
**Solution**: 
- Close other applications
- Increase WSL memory (edit `C:\Users\YourName\.wslconfig`)
- Be patient - first build takes time!

---

## 📊 Expected Timeline

| Step | Time |
|------|------|
| Install WSL | 10 min + restart |
| Install tools | 10-15 min |
| First build | 45-80 min |
| Test in QEMU | 2 min |
| **Total** | **~1.5-2 hours** |

**Next builds**: Only 5-10 minutes! 🚀

---

## 🎉 After Building

You can:
- ✅ Burn ISO to USB with Rufus
- ✅ Run in VirtualBox/VMware
- ✅ Test on real hardware
- ✅ Share with friends
- ✅ Customize and rebuild

---

## 📚 Need More Help?

- **Full guide**: `WINDOWS_BUILD_GUIDE.md`
- **Quick start**: `QUICK_START.md`
- **ISO details**: `BUILDING_ISO.md`
- **Troubleshooting**: `Documentation/Troubleshooting.md`

---

**Ready? Let's build! 🚀**

Start with: `wsl --install` in PowerShell (as Administrator)
