param (
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Files
)

if (-not $Files -or $Files.Count -eq 0) {
  Write-Host ""
  Write-Host "Files are not passed."
  Write-Host "Usage: touch <file1> <file2> ..."
  Write-Host ""
  exit
}

# get touch.exe from build
$exePath = Resolve-Path "$PSScriptRoot\..\build\touch.exe"

# Run touch.exe from build
& $exePath @Files
