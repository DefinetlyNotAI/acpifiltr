# Building acpifiltr

## Requirements

- Windows 11 x64
- Visual Studio 2026 Community with C++ development tools
- Windows Driver Kit (WDK) 10.0.28000.0
- PowerShell 7

## Build

Build the Debug x64 driver:

    .\scripts\Build-Driver.ps1

Build the Release x64 driver:

    .\scripts\Build-Driver.ps1 -Configuration Release

Generated binaries are located in:

- `x64\Debug\`
- `x64\Release\`

## Validation

Validate the Debug build:

    .\scripts\Test-Driver.ps1 -Configuration Debug

Validate the Release build:

    .\scripts\Test-Driver.ps1 -Configuration Release

The validation script checks:

1. INF compliance using Microsoft's InfVerif.
2. Universal Windows Driver API compatibility using ApiValidator.

## Verified Results

Tested with Visual Studio 2026 and WDK 10.0.28000.0.

| Test | Result |
|------|--------|
| Debug x64 compilation | Passed |
| Release x64 compilation | Passed |
| WDK test signing | Passed |
| Driver catalog generation | Passed |
| Debug INF validation | Passed |
| Debug Universal API validation | Passed |

## Driver Signing

The WDK build process generates test-signed driver binaries and catalogs.

Test signing does not authorize loading the driver on a standard Windows installation with Secure Boot and Memory Integrity enabled.

Production deployment requires a signing and trust configuration supported by Windows.

## Installation

The build and validation scripts do not install the driver or modify Windows security settings.
