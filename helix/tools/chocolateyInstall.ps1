$ErrorActionPreference = 'Stop'

$packageName = 'helix'
$url = 'https://github.com/helix-editor/helix/releases/download/25.07.1/helix-25.07.1-x86_64-windows.zip'
$directoryName = (Split-Path $url -Leaf) -replace ".zip"

$packageArgs = @{
  packageName    = $packageName
  url64bit       = $url
  checksum64     = '5c8325ced8bacd8418d62706f669e96d9c3578a9237526e34d546900cbc049b6'
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
