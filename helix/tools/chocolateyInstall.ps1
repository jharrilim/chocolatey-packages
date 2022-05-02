$ErrorActionPreference = 'Stop'

$packageName = 'helix'
$url = 'https://github.com/helix-editor/helix/releases/download/22.03/helix-22.03-x86_64-windows.zip'
$directoryName = (Split-Path $url -Leaf) -replace ".zip"

$packageArgs = @{
  packageName    = $packageName
  url64bit       = $url
  checksum64     = '6ea24df6babe70f6ee28948b460f2a9bab5d7b970dbc74efb67f942168cd6b94'
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
