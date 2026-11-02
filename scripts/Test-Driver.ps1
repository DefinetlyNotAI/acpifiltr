param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug'
)

$ErrorActionPreference = 'Stop'

$kit = 'C:\Program Files (x86)\Windows Kits\10'
$version = '10.0.28000.0'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$output = Join-Path $root "x64\$Configuration"
$inf = Join-Path $output 'acpifiltr.inf'

$infverif = "$kit\Tools\$version\x64\infverif.exe"
$validator = "$kit\bin\$version\x64\ApiValidator.exe"
$rules = "$kit\build\$version\universalDDIs\x64"

foreach ($file in @(
    $inf,
    $infverif,
    $validator,
    "$rules\UniversalDDIs.xml",
    "$rules\ModuleWhiteList.xml"
)) {
    if (!(Test-Path $file)) {
        throw "Missing required file: $file"
    }
}

Write-Host 'Validating INF...'

& $infverif /u $inf

if ($LASTEXITCODE -ne 0) {
    throw "INF validation failed: $LASTEXITCODE"
}

Write-Host 'Validating Universal APIs...'

& $validator `
    "-DriverPackagePath:$output" `
    "-SupportedApiXmlFiles:$rules\UniversalDDIs.xml" `
    "-ModuleWhiteListXmlFiles:$rules\ModuleWhiteList.xml"

if ($LASTEXITCODE -ne 0) {
    throw "API validation failed: $LASTEXITCODE"
}

Write-Host "Validation passed: $Configuration x64"
