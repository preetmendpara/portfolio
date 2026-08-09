# Bumps the ?v= cache-buster on overrides.css / enhancements.js in both HTML files.
# Needed because preetmendpara.qzz.io is a subdomain of DigitalPlat's Cloudflare
# zone, which rewrites our Cache-Control to max-age=14400 — the URL itself has to
# change for edits to reach visitors. Called by deploy.bat.

$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

$files = 'public/index.html', 'public/404.html'
$n = [int][regex]::Match((Get-Content 'public/index.html' -Raw -Encoding UTF8), 'overrides\.css\?v=(\d+)').Groups[1].Value + 1

# UTF8Encoding($false) => no BOM. Set-Content -Encoding utf8 would add one.
$enc = New-Object System.Text.UTF8Encoding $false

foreach ($f in $files) {
    # -Encoding UTF8 is required: PowerShell 5.1 otherwise reads as system ANSI
    # and mangles the em dashes in the page title into "â€”".
    $text = (Get-Content $f -Raw -Encoding UTF8) `
        -replace 'overrides\.css\?v=\d+', "overrides.css?v=$n" `
        -replace 'enhancements\.js\?v=\d+', "enhancements.js?v=$n"
    [System.IO.File]::WriteAllText((Resolve-Path $f), $text, $enc)
}

Write-Host "cache version -> v=$n"
