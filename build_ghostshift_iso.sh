#!/bin/bash
# Build GhostShift OS and create bootable ISO image

set -e

echo "🚀 Building GhostShift OS ISO Image..."
echo ""

# Check if we're in the right directory
if [ ! -f "Meta/serenity.sh" ]; then
    echo "❌ Error: Please run this script from the GhostShift OS root directory"
    exit 1
fi

# Step 1: Build the toolchain (if not already built)
echo "📦 Step 1: Building toolchain..."
if [ ! -d "Toolchain/Local" ]; then
    echo "Building cross-compiler toolchain (this will take a while)..."
    Meta/serenity.sh rebuild-toolchain
else
    echo "✓ Toolchain already built"
fi

# Step 2: Build GhostShift OS
echo ""
echo "🔨 Step 2: Building GhostShift OS..."
Meta/serenity.sh build

# Step 3: Create ISO image
echo ""
echo "💿 Step 3: Creating bootable ISO image..."

# The build system creates a disk image, we need to convert it to ISO
BUILD_DIR="Build/x86_64"
DISK_IMAGE="$BUILD_DIR/_disk_image"
ISO_OUTPUT="GhostShift-OS.iso"

if [ -f "$DISK_IMAGE" ]; then
    echo "Creating ISO from disk image..."
    
    # Create ISO directory structure
    mkdir -p iso_root/boot/grub
    
    # Copy kernel and boot files
    cp "$BUILD_DIR/Kernel/Kernel" iso_root/boot/kernel
    
    # Create GRUB config
    cat > iso_root/boot/grub/grub.cfg << 'EOF'
set timeout=3
set default=0

menuentry "GhostShift OS" {
    multiboot /boot/kernel
    boot
}
EOF
    
    # Create ISO using grub-mkrescue or xorriso
    if command -v grub-mkrescue &> /dev/null; then
        grub-mkrescue -o "$ISO_OUTPUT" iso_root
        echo "✓ ISO created using grub-mkrescue"
    elif command -v xorriso &> /dev/null; then
        xorriso -as mkisofs -o "$ISO_OUTPUT" -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table iso_root
        echo "✓ ISO created using xorriso"
    else
        echo "⚠️  Neither grub-mkrescue nor xorriso found"
        echo "Installing required tools..."
        sudo apt-get install -y grub-pc-bin xorriso
        grub-mkrescue -o "$ISO_OUTPUT" iso_root
    fi
    
    # Cleanup
    rm -rf iso_root
    
    echo ""
    echo "✅ GhostShift OS ISO created successfully!"
    echo ""
    echo "📀 ISO Location: $(pwd)/$ISO_OUTPUT"
    echo "📊 ISO Size: $(du -h $ISO_OUTPUT | cut -f1)"
    echo ""
    echo "🔥 You can now:"
    echo "  • Burn to USB: sudo dd if=$ISO_OUTPUT of=/dev/sdX bs=4M status=progress"
    echo "  • Test in QEMU: qemu-system-x86_64 -cdrom $ISO_OUTPUT -m 2G"
    echo "  • Use in VirtualBox/VMware"
    echo ""
else
    echo "❌ Error: Disk image not found at $DISK_IMAGE"
    echo "Build may have failed. Check the output above."
    exit 1
fi
