# Building the Grove Foundation Loop Skill Package

This document explains how to package the skill for distribution.

## Quick Start

Double-click `build-skill.bat` or run from command line:

```batch
build-skill.bat
```

This creates a ZIP file in the `dist/` folder ready for distribution.

## Usage Options

| Command | Description |
|---------|-------------|
| `build-skill.bat` | Build the skill package |
| `build-skill.bat "" output` | Build with custom output directory |

### PowerShell Direct Usage

```powershell
.\build-skill.ps1                           # Default build
.\build-skill.ps1 -OutputDir "release"      # Custom output directory
```

## Output Structure

The script creates a properly formatted skill package:

```
dist/
└── grove-foundation-loop.zip
    ├── SKILL.md              # Core skill definition (at root)
    ├── README.md             # Quick start guide
    ├── LICENSE               # MIT license
    ├── references/
    │   ├── templates.md      # 8 artifact templates
    │   ├── testing-requirements.md
    │   ├── grove-architecture-rules.md
    │   ├── health-report.md
    │   └── examples.md
    └── scripts/
        └── init-sprint.js    # Sprint initialization utility
```

**Note:** SKILL.md must be at the ZIP root level (not inside a subfolder) per Claude Skills requirements.

## What's Included

| File/Folder | Purpose |
|-------------|---------|
| `SKILL.md` | Skill definition with activation triggers and methodology |
| `README.md` | Installation and usage instructions |
| `LICENSE` | MIT license |
| `references/` | Templates, examples, and architecture guides |
| `scripts/` | Utility scripts (sprint initialization) |

## What's Excluded

The following are automatically excluded from the package:

- `.git/` - Source control history
- `.claude/` - Local Claude configuration
- `assets/` - Empty placeholder directory
- `dist/` - Build output directory
- `build-skill.bat` / `build-skill.ps1` - Build scripts themselves
- `BUILD.md` - This file

## Claude Skills Naming Requirements

The ZIP filename must follow Claude Skills specifications:

- **Lowercase only** - No uppercase letters
- **Hyphens for separators** - No spaces, underscores, or special characters
- **Match skill name** - ZIP name must match the `name` in SKILL.md frontmatter
- **Match folder name** - The folder inside the ZIP must also match

This script automatically enforces these rules by using the skill name directly.

## Requirements

- Windows with PowerShell 5.0+ (included in Windows 10/11)
- No additional dependencies required

## Troubleshooting

**"Execution policy" error:**
The batch file handles this automatically. If running PowerShell directly:
```powershell
powershell -ExecutionPolicy Bypass -File build-skill.ps1
```

**Missing files warning:**
The script will warn (yellow text) if expected files are missing but will continue building with available files.

**ZIP already exists:**
The script automatically overwrites existing ZIP files.
