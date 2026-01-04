# build-skill.ps1
# Packages the Grove Foundation Loop Skill into a distributable ZIP file
# Usage: .\build-skill.ps1 [-OutputDir "dist"]

param(
    [string]$OutputDir = "dist"
)

# Load required assemblies for ZIP operations
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Get script directory (where the skill files are)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Skill name (matches SKILL.md front matter)
$SkillName = "grove-foundation-loop"

# Create output directory
$OutputPath = Join-Path $ScriptDir $OutputDir
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Define the ZIP filename (must match skill name exactly per Claude Skills spec)
$ZipFileName = "${SkillName}.zip"
$ZipFilePath = Join-Path $OutputPath $ZipFileName

# Remove existing ZIP if present
if (Test-Path $ZipFilePath) {
    Remove-Item $ZipFilePath -Force
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Grove Foundation Loop Skill Packager" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Output:     $ZipFilePath" -ForegroundColor Yellow
Write-Host ""

Write-Host "Packaging skill files..." -ForegroundColor Green

# Define files and folders to include
$FilesToInclude = @(
    "SKILL.md",
    "README.md",
    "LICENSE"
)

$FoldersToInclude = @(
    "references",
    "scripts"
)

# Create ZIP with forward slashes (required by Claude Skills)
try {
    $zip = [System.IO.Compression.ZipFile]::Open($ZipFilePath, [System.IO.Compression.ZipArchiveMode]::Create)

    # Add individual files at root level
    foreach ($file in $FilesToInclude) {
        $sourcePath = Join-Path $ScriptDir $file
        if (Test-Path $sourcePath) {
            # Entry name uses forward slash (file at root, so just filename)
            $entryName = $file
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $sourcePath, $entryName, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
            Write-Host "  + $entryName" -ForegroundColor DarkGray
        } else {
            Write-Host "  ! $file (not found, skipping)" -ForegroundColor Yellow
        }
    }

    # Add folders with forward slashes in paths
    foreach ($folder in $FoldersToInclude) {
        $folderPath = Join-Path $ScriptDir $folder
        if (Test-Path $folderPath) {
            $files = Get-ChildItem $folderPath -Recurse -File
            foreach ($file in $files) {
                $relativePath = $file.FullName.Substring($ScriptDir.Length + 1)
                # Convert backslashes to forward slashes (CRITICAL for Claude Skills)
                $entryName = $relativePath -replace '\\', '/'
                [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $entryName, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
                Write-Host "  + $entryName" -ForegroundColor DarkGray
            }
        } else {
            Write-Host "  ! $folder/ (not found, skipping)" -ForegroundColor Yellow
        }
    }

    $zip.Dispose()

    # Get final ZIP size
    $zipSize = (Get-Item $ZipFilePath).Length
    $zipSizeKB = [math]::Round($zipSize / 1024, 2)

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Build Complete!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Output:     $ZipFilePath" -ForegroundColor White
    Write-Host "Size:       $zipSizeKB KB" -ForegroundColor White
    Write-Host ""

    # Verify and list contents of the ZIP
    Write-Host "Package contents (verifying forward slashes):" -ForegroundColor Yellow
    $zipContents = [System.IO.Compression.ZipFile]::OpenRead($ZipFilePath)
    $hasBackslash = $false
    foreach ($entry in $zipContents.Entries) {
        if ($entry.Name) {
            $sizeKB = [math]::Round($entry.Length / 1024, 1)
            $pathIndicator = ""
            if ($entry.FullName -match '\\') {
                $pathIndicator = " [ERROR: backslash detected!]"
                $hasBackslash = $true
            }
            Write-Host "  $($entry.FullName) ($sizeKB KB)$pathIndicator" -ForegroundColor DarkGray
        }
    }
    $zipContents.Dispose()

    if ($hasBackslash) {
        Write-Host ""
        Write-Host "WARNING: Backslashes detected in ZIP paths!" -ForegroundColor Red
        Write-Host "Claude Skills requires forward slashes only." -ForegroundColor Red
    } else {
        Write-Host ""
        Write-Host "All paths use forward slashes." -ForegroundColor Green
    }

} catch {
    Write-Host "ERROR: Failed to create ZIP file" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Done! The skill package is ready for distribution." -ForegroundColor Green
