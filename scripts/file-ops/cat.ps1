# Parse manual args
$parsed = @{}
for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        '-infile' { $parsed.infile = $args[++$i] }
        '-outfile' { $parsed.outfile = $args[++$i] }
        '-addfile' { $parsed.addfile = $args[++$i] }
    }
}

function multiline_input {
    $lines = @()
    Write-Host "Input ('--end' to stop):"
    while ($true) {
        $line = Read-Host
        if ($line -ieq '--end') { break }
        $lines += $line
    }
    return $lines
}

# Conflict check
if ($parsed.infile -and $parsed.addfile) {
    Write-Host "Error: Cannot use both -infile and -addfile at the same time." -ForegroundColor Red
    exit
}

# Case 1: Copy infile to outfile
if ($parsed.infile -and $parsed.outfile) {
    if (-not (Test-Path $parsed.infile)) {
        Write-Host "File $($parsed.infile) not found!"
        exit
    }
    Get-Content $parsed.infile | Set-Content $parsed.outfile
    Write-Host "Copied $($parsed.infile) to $($parsed.outfile) successfully."
    exit
}

# Case 2: Multi-line input to infile
if ($parsed.infile -and -not $parsed.outfile) {
    $lines = multiline_input
    $lines | Set-Content $parsed.infile
    Write-Host "Successfully saved contents in $($parsed.infile)."
    exit
}

# Case 3: Append input to addfile
if ($parsed.addfile) {
    if (-not (Test-Path $parsed.addfile)) {
        Write-Host "File $($parsed.addfile) not found!"
        exit
    }
    $lines = multiline_input
    $lines | Add-Content $parsed.addfile
    Write-Host "Successfully appended to $($parsed.addfile)."
    exit
}

# Case 4: Show contents of outfile
if ($parsed.outfile -and -not $parsed.infile -and -not $parsed.addfile) {
    if (-not (Test-Path $parsed.outfile)) {
        Write-Host "File $($parsed.outfile) not found!"
        exit
    }
    Get-Content $parsed.outfile
    exit
}
