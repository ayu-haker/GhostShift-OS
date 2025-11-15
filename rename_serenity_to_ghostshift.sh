#!/bin/bash
# Script to rename all SerenityOS references to GhostShift OS

echo "🔄 Renaming SerenityOS to GhostShift OS..."

# Files to update (excluding toolchain patches and git history)
FILES_TO_UPDATE=(
    "Documentation/*.md"
    "Base/home/anon/README.md"
    "*.md"
)

# Function to replace text in files
replace_in_files() {
    local pattern=$1
    local replacement=$2
    local file_pattern=$3
    
    find . -type f -name "$file_pattern" \
        -not -path "*/\.git/*" \
        -not -path "*/Toolchain/Patches/*" \
        -not -path "*/Build/*" \
        -exec sed -i "s/$pattern/$replacement/g" {} +
}

# Replace SerenityOS with GhostShift OS
echo "📝 Replacing 'SerenityOS' with 'GhostShift OS'..."
replace_in_files "SerenityOS" "GhostShift OS" "*.md"

# Replace Serenity OS with GhostShift OS
echo "📝 Replacing 'Serenity OS' with 'GhostShift OS'..."
replace_in_files "Serenity OS" "GhostShift OS" "*.md"

# Replace serenity with ghostshift in URLs
echo "🔗 Updating GitHub URLs..."
replace_in_files "github\.com/SerenityOS/serenity" "github.com/ayu-haker/GhostShift-OS" "*.md"
replace_in_files "serenityos\.org" "github.com/ayu-haker/GhostShift-OS" "*.md"

# Update specific documentation files
echo "📚 Updating documentation..."
sed -i 's/serenity/ghostshift/g' Documentation/WritingManPages.md 2>/dev/null || true
sed -i 's/man\.serenityos\.org/man.ghostshift.dev/g' Documentation/*.md 2>/dev/null || true

echo ""
echo "✅ Renaming complete!"
echo ""
echo "Note: Toolchain patches were NOT modified (they reference upstream LLVM/GCC)"
echo ""
