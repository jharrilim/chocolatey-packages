$ErrorActionPreference = 'Stop'

$packageName = 'helix'
$url = 'https://github.com/helix-editor/helix/releases/download/25.01.1/helix-25.01.1-x86_64-windows.zip'
$directoryName = (Split-Path $url -Leaf) -replace ".zip"

$packageArgs = @{
  packageName    = $packageName
  url64bit       = $url
  checksum64     = '564055657cf24a4ebb0ef929ee2bc40d379431868e06fd82e41a0def01a5a320'
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}

$helixRuntimePath = "%ChocolateyInstall%\lib\$packageName\tools\$directoryName\runtime"

Install-ChocolateyZipPackage @packageArgs

Write-Host "Setting HELIX_RUNTIME path to: '$helixRuntimePath'"
Install-ChocolateyEnvironmentVariable `
  -VariableName "HELIX_RUNTIME" `
  -VariableValue $helixRuntimePath `
  -VariableType Machine
