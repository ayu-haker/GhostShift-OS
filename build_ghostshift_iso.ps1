# PowerShell script to build GhostShift OS ISO (for WSL)

Write-Host "`n🚀 Building GhostShift OS ISO Image...`n" -ForegroundColor Green

# Check if WSL is available
$wslAvailable = Get-Command wsl -ErrorAction SilentlyContinue

if (-not $wslAvailable) {
    Write-Host "❌ WSL not found! Please install WSL first:" -ForegroundColor Red
    Write-Host "   wsl --install" -ForegroundColor Yellow
    Write-Host "`nOr use the Linux build script in WSL/Linux directly.`n" -ForegroundColor Yellow
    exit 1
}

Write-Host "📋 Checking WSL setup..." -ForegroundColor Cyan

# Get current directory in WSL format
$currentDir = (Get-Location).Path
$wslPath = $currentDir -replace '\\', '/' -replace '^([A-Z]):', { "/mnt/$($_.Groups[1].Value.ToLower())" }

Write-Host "Working directory: $wslPath`n" -ForegroundColor Gray

# Check if build script exists
if (-not (Test-Path "Meta\serenity.sh")) {
    Write-Host "❌ Error: Not in GhostShift OS root directory!" -ForegroundColor Red
    exit 1
}

Write-Host "🔧 Running build in WSL...`n" -ForegroundColor Cyan

# Make the script executable and run it in WSL
wsl bash -c "cd '$wslPath' && chmod +x build_ghostshift_iso.sh && ./build_ghostshift_iso.sh"

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Build completed successfully!" -ForegroundColor Green
    
    if (Test-Path "GhostShift-OS.iso") {
        $isoSize = (Get-Item "GhostShift-OS.iso").Length / 1MB
        Write-Host "`n📀 ISO Details:" -ForegroundColor Cyan
        Write-Host "   Location: $(Get-Location)\GhostShift-OS.iso" -ForegroundColor White
        Write-Host "   Size: $([math]::Round($isoSize, 2)) MB`n" -ForegroundColor White
    }
} else {
    Write-Host "`n❌ Build failed! Check the output above for errors.`n" -ForegroundColor Red
    exit 1
}
