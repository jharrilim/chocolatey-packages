import-module au

$releases = 'https://github.com/helix-editor/helix/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
    7z e tools\*.zip -otools *.exe -r -y
    Remove-Item tools\*.zip -ea 0
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url64 = $download_page.links | ? href -match '-x86_64-windows.zip$' | % href | select -First 1
    $version = (Split-Path ( Split-Path $url64 ) -Leaf).Substring(1)

    @{
        URL64        = 'https://github.com' + $url64
        Version      = $version
        ReleaseNotes = "https://github.com/flameshot-org/flameshot/releases/tag/v${version}"
    }
}

update
