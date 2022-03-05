$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'helix'
  fileType               = 'exe'
  url                    = 'https://github.com/helix-editor/helix/releases/download/v0.6.0/helix-v0.6.0-x86_64-windows.zip'
  url64bit               = 'https://github.com/helix-editor/helix/releases/download/v0.6.0/helix-v0.6.0-x86_64-windows.zip'
  checksum64             = '23F4FE46F30E489938AD2FABFB768A024528EFF437121356398F6839DDACB2B9'
  checksumType64         = 'sha256'
  silentArgs             = '/qn'
  validExitCodes         = @(0)
  softwareName           = 'helix*'
}

Install-ChocolateyPackage @packageArgs
