$ErrorActionPreference = 'Stop'

$packageName = 'helix'
$url = 'https://github.com/helix-editor/helix/releases/download/23.05/helix-23.05-x86_64-windows.zip'
$directoryName = (Split-Path $url -Leaf) -replace ".zip"

$packageArgs = @{
  packageName    = $packageName
  url64bit       = $url
  checksum64     = '27ba9a7ea0cbb5a4de2378c5d7383405f2aeb254118cfba1785eb0b32aee3ef0'
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
