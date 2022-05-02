import-module au

$releases = 'https://github.com/helix-editor/helix/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\`$url\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType64\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_BeforeUpdate {
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64 -Algorithm $Latest.ChecksumType64
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url64 = $download_page.links | ? href -match '-x86_64-windows.zip$' | % href | select -First 1
    $version = (Split-Path ( Split-Path $url64 ) -Leaf).Substring(1)

    @{
        URL64        = 'https://github.com' + $url64
        Version      = $version
        ReleaseNotes = "https://github.com/helix-editor/helix/releases/tag/v${version}"
    }
}

update -ChecksumFor 64
