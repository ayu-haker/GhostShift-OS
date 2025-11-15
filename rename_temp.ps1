# PowerShell script to rename all SerenityOS references to GhostShift OS

Write-Host "ðŸ”„ Renaming SerenityOS to GhostShift OS..." -ForegroundColor Green

# Get all markdown files (excluding toolchain patches and git)
$files = Get-ChildItem -Path . -Include *.md -Recurse -File | 
    Where-Object { 
        $_.FullName -notmatch '\\\.git\\' -and 
        $_.FullName -notmatch '\\Toolchain\\Patches\\' -and
        $_.FullName -notmatch '\\Build\\'
    }

$count = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
    
    if ($content) {
        $modified = $false
        $newContent = $content
        
        # Replace SerenityOS with GhostShift OS
        if ($newContent -match 'SerenityOS') {
            $newContent = $newContent -replace 'SerenityOS', 'GhostShift OS'
            $modified = $true
        }
        
        # Replace Serenity OS with GhostShift OS
        if ($newContent -match 'Serenity OS') {
            $newContent = $newContent -replace 'Serenity OS', 'GhostShift OS'
            $modified = $true
        }
        
        # Update GitHub URLs
        if ($newContent -match 'github\.com/SerenityOS/serenity') {
            $newContent = $newContent -replace 'github\.com/SerenityOS/serenity', 'github.com/ayu-haker/GhostShift-OS'
            $modified = $true
        }
        
        # Update serenityos.org URLs
        if ($newContent -match 'serenityos\.org') {
            $newContent = $newContent -replace 'serenityos\.org', 'github.com/ayu-haker/GhostShift-OS'
            $modified = $true
        }
        
        # Update man page URLs
        if ($newContent -match 'man\.serenityos\.org') {
            $newContent = $newContent -replace 'man\.serenityos\.org', 'man.ghostshift.dev'
            $modified = $true
        }
        
        if ($modified) {
            Set-Content -Path $file.FullName -Value $newContent -NoNewline
            $count++
            Write-Host "  âœ“ Updated: $($file.Name)" -ForegroundColor Cyan
        }
    }
}

Write-Host ""
Write-Host "âœ… Renaming complete! Updated $count files." -ForegroundColor Green
Write-Host ""
Write-Host "Note: Toolchain patches were NOT modified" -ForegroundColor Yellow
Write-Host ""
