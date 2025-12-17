param(
    [string]$file
)

if (-not (Test-Path $file)) {
    Write-Host "File not found: $file"
    exit 1
}

$file = Resolve-Path $file
$extension = [System.IO.Path]::GetExtension($file).ToLower()
$filename = [System.IO.Path]::GetFileNameWithoutExtension($file)

function writer() {
    Write-Host "Successfully Compiled"
    Write-Host "`nRunning...`n"
}

switch ($extension) {
    ".c" {
        Write-Host "Compiling C..."
        gcc $file -o "$filename.exe"
        if ($LASTEXITCODE -ne 0) { Write-Host "Compilation failed"; exit 1 }
        writer
        & ".\$filename.exe"
    }
    ".cpp" {
        Write-Host "Compiling C++..."
        try {
            $gccVerStr = g++ -dumpversion   
            $majorVer = [int]($gccVerStr -split '\.')[0]
        } catch {
            $majorVer = 0 
        }
        if ($majorVer -ge 13) {
            $stdFlag = "-std=c++23"
        } elseif ($majorVer -ge 11) {
            $stdFlag = "-std=c++20"
        } elseif ($majorVer -ge 8) {
            $stdFlag = "-std=c++17"
        } else {
            $stdFlag = "-std=c++14" # For very old compilers
        }
        Write-Host "Detected GCC v$majorVer. Using flag: $stdFlag"
        g++ $file -O3 -Wall -Wextra $stdFlag -o "$filename.exe"
        if ($LASTEXITCODE -ne 0) { Write-Host "Compilation failed"; exit 1 }
        writer
        & ".\$filename.exe"
    }
    ".java" {
        Write-Host "Compiling Java..."
        javac $file
        if ($LASTEXITCODE -ne 0) { Write-Host "Compilation failed"; exit 1 }
        writer
        java $filename
    }
    ".py" {
        Write-Host "Executing Python..."
        python $file
    }
    ".go" {
        Write-Host "Executing Go..."
        go run $file
    }
    ".rs" {
        Write-Host "Compiling Rust..."
        rustc $file -o "$filename.exe"
        if ($LASTEXITCODE -ne 0) { Write-Host "Compilation failed"; exit 1 }
        writer
        & ".\$filename.exe"
    }
    default {
        Write-Host "File format not supported: $extension"
        exit 1
    }
}

Write-Host "`nExecuted Successfully"
