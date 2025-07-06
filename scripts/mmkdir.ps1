param (
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Folders
)

# path variable mkdir.exe from build
$exePath = Resolve-Path "$PSScriptRoot\..\build\mmkdir.exe"

# execute mkdir program
& $exePath @Folders 