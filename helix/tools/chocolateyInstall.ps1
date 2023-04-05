$ErrorActionPreference = 'Stop'

$packageName = 'helix'
$url = 'https://github.com/helix-editor/helix/releases/download/23.03/helix-23.03-x86_64-windows.zip'
$directoryName = (Split-Path $url -Leaf) -replace ".zip"

$packageArgs = @{
  packageName    = $packageName
  url64bit       = $url
  checksum64     = '58013f827d676a9dcb3efdf81e8202abc10e6665f977acb7edf2ba325645ddfb'
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
