# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AVP-Streaming-Setup is a PowerShell module that automates the installation and configuration of Sunshine game streaming server on Windows. The module provides cmdlets to install Sunshine, configure Windows Firewall rules, and manage the Sunshine service.

## Key Commands

### Testing
```powershell
# Run Pester tests
Invoke-Pester -Path .\tests\AVPSunshine.Tests.ps1

# Run with verbose output
Invoke-Pester -Path .\tests\AVPSunshine.Tests.ps1 -Verbose
```

### Module Development
```powershell
# Import module for testing
Import-Module .\src\AVPSunshine -Force

# Test individual functions
Install-AVPSunshine -WhatIf
Enable-AVPSunshineFirewall -WhatIf
Start-AVPSunshineService
```

### Building Package Installers
```powershell
# Build Chocolatey package
choco pack .\packaging\choco\avp-sunshine.nuspec

# Test Scoop manifest
scoop install .\packaging\scoop\avp-sunshine.json
```

## Architecture

The project follows a standard PowerShell module structure:

- **src/AVPSunshine/**: Core module with manifest (.psd1) and module script (.psm1)
  - `Install-AVPSunshine`: Downloads and installs Sunshine silently
  - `Enable-AVPSunshineFirewall`: Opens required ports (47984, 47989, 47990) in Windows Firewall
  - `Start-AVPSunshineService`: Starts the Sunshine service

- **packaging/**: Distribution packages for Chocolatey and Scoop package managers
  - Chocolatey package includes automated installation script
  - Scoop manifest for bucket-based installation

- **tests/**: Pester tests validating service installation and firewall configuration

## Important Technical Details

- Requires PowerShell 5.1 or higher
- All cmdlets support `-WhatIf` parameter for testing without making changes
- Firewall rules are created with specific naming convention: `AVPSunshine-{port}`
- Default Sunshine ports: 47984 (HTTP), 47989 (HTTPS), 47990 (Web UI)
- Service name: "Sunshine"

## Git Repository

- **Repository URL**: https://github.com/BHPAV/AVP-Streaming-Setup
- **Default branch**: main
- **Visibility**: Public

### Common Git Commands
```powershell
# Check repository status
git status

# Pull latest changes
git pull

# Create and switch to feature branch
git checkout -b feature/branch-name

# Stage changes
git add .

# Commit changes
git commit -m "Description of changes"

# Push branch to remote
git push -u origin feature/branch-name
```

## GitHub Workflows

The repository includes GitHub Actions workflows:
- **CI Workflow** (.github/workflows/ci.yml): Continuous integration pipeline
- **Documentation** (.github/workflows/docs.yml): Documentation build and deployment