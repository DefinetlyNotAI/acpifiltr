param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug'
)

$ErrorActionPreference = 'Stop'

$project = Join-Path $PSScriptRoot '..\acpifiltr.vcxproj'
$msbuild = 'C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\MSBuild.exe'

if (!(Test-Path $msbuild)) {
    throw "MSBuild not found: $msbuild"
}

& $msbuild $project `
    /t:Rebuild `
    "/p:Configuration=$Configuration" `
    /p:Platform=x64 `
    /p:WindowsTargetPlatformVersion=10.0.28000.0 `
    /p:SkipPackageVerification=true `
    /p:ApiValidator_Enable=false `
    /verbosity:minimal `
    /nologo

if ($LASTEXITCODE -ne 0) {
    throw "Build failed with exit code $LASTEXITCODE"
}

Write-Host "Build completed: $Configuration x64"
