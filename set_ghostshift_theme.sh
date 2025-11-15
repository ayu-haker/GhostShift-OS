#!/bin/bash
# Set GhostShift OS theme and wallpaper

echo "🎨 Setting up GhostShift OS theme..."

# Create wallpapers directory if it doesn't exist
mkdir -p Base/res/wallpapers
mkdir -p Base/res/graphics

# Generate the wallpaper
echo "📸 Generating GhostShift wallpaper..."
python3 create_ghostshift_wallpaper.py

# Update the default wallpaper config
CONFIG_FILE="Base/home/anon/.config/WindowServer.ini"
mkdir -p "$(dirname "$CONFIG_FILE")"

cat > "$CONFIG_FILE" << 'EOF'
[Background]
Wallpaper=/res/wallpapers/ghostshift.png
Mode=Fill
Color=#000a05

[Cursor]
Theme=Default

[Effects]
AnimateMenus=true
AnimateWindows=true
FlashMenus=true
EOF

echo "✓ WindowServer config updated"

# Update system theme colors to match GhostShift
THEME_FILE="Base/res/themes/GhostShift.ini"
mkdir -p "$(dirname "$THEME_FILE")"

cat > "$THEME_FILE" << 'EOF'
[Colors]
Accent=#00ff64
ActiveLink=#00ff64
ActiveWindowBorder1=#00b446
ActiveWindowBorder2=#008832
ActiveWindowTitle=#00ff64
ActiveWindowTitleShadow=#000000
ActiveWindowTitleStripes=#00b446
Base=#0a1a0f
BaseText=#00ff64
Button=#1a2a1f
ButtonText=#00ff64
DesktopBackground=#000a05
FocusOutline=#00ff64
HighlightWindowBorder1=#00ff64
HighlightWindowBorder2=#00b446
HighlightWindowTitle=#00ff64
HighlightWindowTitleShadow=#000000
HighlightWindowTitleStripes=#00b446
HoverHighlight=#00b446
InactiveSelection=#1a2a1f
InactiveSelectionText=#00b446
InactiveWindowBorder1=#0a1a0f
InactiveWindowBorder2=#050f0a
InactiveWindowTitle=#00b446
InactiveWindowTitleShadow=#000000
InactiveWindowTitleStripes=#0a1a0f
Link=#00ff64
MenuBase=#0a1a0f
MenuBaseText=#00ff64
MenuSelection=#00b446
MenuSelectionText=#ffffff
MenuStripe=#050f0a
MovingWindowBorder1=#00ff64
MovingWindowBorder2=#00b446
MovingWindowTitle=#00ff64
MovingWindowTitleShadow=#000000
MovingWindowTitleStripes=#00b446
PlaceholderText=#00b446
RubberBandBorder=#00ff64
RubberBandFill=#00b44640
Ruler=#1a2a1f
RulerActiveText=#00ff64
RulerBorder=#00b446
RulerInactiveText=#008832
Selection=#00b446
SelectionText=#ffffff
SyntaxComment=#008832
SyntaxControlKeyword=#00ff64
SyntaxIdentifier=#00ff64
SyntaxKeyword=#00ff64
SyntaxNumber=#00b446
SyntaxOperator=#00ff64
SyntaxPreprocessorStatement=#00b446
SyntaxPreprocessorValue=#008832
SyntaxPunctuation=#00ff64
SyntaxString=#00b446
SyntaxType=#00ff64
TextCursor=#00ff64
ThreedHighlight=#00b446
ThreedShadow1=#050f0a
ThreedShadow2=#000a05
Tooltip=#1a2a1f
TooltipText=#00ff64
Tray=#0a1a0f
TrayText=#00ff64
VisitedLink=#00b446
Window=#0a1a0f
WindowText=#00ff64

[Metrics]
TitleHeight=19
TitleButtonHeight=15
TitleButtonWidth=15

[Fonts]
TitleBold=true

[Paths]
TitleButtonIcons=/res/icons/16x16/
EOF

echo "✓ GhostShift theme created"

echo ""
echo "✅ GhostShift OS theme setup complete!"
echo ""
echo "To apply the theme:"
echo "1. Build the OS: Meta/serenity.sh build"
echo "2. Run the OS: Meta/serenity.sh run"
echo "3. In the OS, go to Settings → Theme and select 'GhostShift'"
echo ""
