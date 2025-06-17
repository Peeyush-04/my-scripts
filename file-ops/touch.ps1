param(
    [string]$file_name
)

if(-not $file_name) {
    Write-Host "Usage: touch <file-name>"
    exit
}

New-Item -ItemType File -Path $file_name -Force 