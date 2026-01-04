@echo off
REM build-skill.bat
REM Wrapper script to package the Grove Foundation Loop Skill
REM
REM Usage:
REM   build-skill.bat              - Build with auto-versioning (date-based or git tag)
REM   build-skill.bat 1.2.0        - Build with specific version number
REM   build-skill.bat 1.2.0 dist   - Build with version and custom output directory

setlocal EnableDelayedExpansion

REM Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

REM Parse arguments
set "VERSION=%~1"
set "OUTPUT_DIR=%~2"

REM Build the PowerShell command
set "PS_CMD=powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%build-skill.ps1""

if not "%VERSION%"=="" (
    set "PS_CMD=!PS_CMD! -Version "%VERSION%""
)

if not "%OUTPUT_DIR%"=="" (
    set "PS_CMD=!PS_CMD! -OutputDir "%OUTPUT_DIR%""
)

REM Execute the PowerShell script
%PS_CMD%

REM Capture the exit code
set "EXIT_CODE=%ERRORLEVEL%"

REM Pause if there was an error (so user can see it)
if %EXIT_CODE% NEQ 0 (
    echo.
    echo Build failed with exit code %EXIT_CODE%
    pause
)

exit /b %EXIT_CODE%
