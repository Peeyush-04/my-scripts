param (
    [string]$cmd,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$args
)

$root = $PSScriptRoot
$target = "$cmd.ps1"
$found = $false

$scripts = Get-ChildItem -Path $root -Recurse -Filter *.ps1

for($i = 0; $i -lt $scripts.Count; $i++) {
    $script = $scripts[$i]
    if($script.Name -ieq $target) {
        $found = $true
        & $script.FullName @args
        break
    }
}

if(-not $found) {
    Write-Host "=>Command '$cmd' not found!!" -ForegroundColor Red
    exit 1
}