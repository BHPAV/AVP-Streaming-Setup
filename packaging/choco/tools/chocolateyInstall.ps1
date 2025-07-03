$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$installerUrl = 'https://github.com/LizardByte/Sunshine/releases/latest/download/SunshineSetup.exe'
$installerPath = Join-Path $toolsDir 'SunshineSetup.exe'

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath $installerPath -Url $installerUrl

Write-Host "Running Sunshine silent installer..."
Start-Process -FilePath $installerPath -ArgumentList '/SILENT' -Wait

Write-Host 'Sunshine installation complete.'
Write-Host 'For additional configuration, open PowerShell as Administrator and run:'
Write-Host '  Install-AVPSunshine' 