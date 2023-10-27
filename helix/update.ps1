import-module au

$releases = 'https://api.github.com/repos/helix-editor/helix/releases'

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
    $json = $download_page.Content | ConvertFrom-Json
    $latest_release = $json[0]
    $windows_x64_asset = $latest_release.assets | ? browser_download_url -match '-x86_64-windows.zip$'
    $url64 = $windows_x64_asset.browser_download_url

    # The inner Split-Path Turns the URL that looks like
    # https://github.com/helix-editor/helix/releases/download/23.10/helix-23.10-x86_64-windows.zip
    # into
    # https://github.com/helix-editor/helix/releases/download/23.10
    # The outer Split-Path then gets the leaf/edge of that URL, ie. the 23.10 part.
    $version = (Split-Path ( Split-Path $url64 ) -Leaf)

    @{
        URL64        = $url64
        Version      = $version
        ReleaseNotes = "https://github.com/helix-editor/helix/releases/tag/v${version}"
    }
}

update -ChecksumFor 64
