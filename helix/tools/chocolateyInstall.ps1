$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'helix'
  fileType               = 'zip'
  url64bit               = 'https://github.com/prey/prey-node-client/releases/download/v1.6.6/prey-windows-1.6.6-x64.msi'
  checksum64             = '49cbdd7dc73c3a675d1f0c6615db4a7e2809475120109ffda4f27465b4871843'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'helix*'
}
Install-ChocolateyPackage @packageArgs
