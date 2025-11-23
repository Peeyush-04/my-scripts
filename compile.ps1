
param(
    [switch]$clean
)

# Compiler/interpreters
$CC = "gcc"
$CXX = "g++"
$PYTHON = "python"

# Directories
$BUILD_DIR = "build"
$SRC_DIR = "src"

# Check if programs file exists
if (-not (Test-Path "programs")) {
    Write-Host "Error: 'programs' file not found."
    exit 1
}

# Read programs from 'programs' file, ignore empty lines
$PROGRAMS = Get-Content "programs" | Where-Object { $_.Trim() -ne "" }

# Functions
function Ensure-BuildDir {
    if (-not (Test-Path $BUILD_DIR)) {
        New-Item -ItemType Directory -Path $BUILD_DIR | Out-Null
    }
}

function Clean-BuildDir {
    if (Test-Path $BUILD_DIR) {
        Remove-Item -Path $BUILD_DIR -Recurse -Force
        Write-Host "Cleaned $BUILD_DIR"
    }
}


if ($clean) {
    Clean-BuildDir
    exit
}

Ensure-BuildDir

foreach ($prog in $PROGRAMS) {
    $src = Join-Path $SRC_DIR $prog

    if (-not (Test-Path $src)) {
        Write-Host "Skipping $src — file not found"
        continue
    }

    $ext = [System.IO.Path]::GetExtension($prog).ToLower()

    switch ($ext) {
        ".c" {
            $out = Join-Path $BUILD_DIR ([System.IO.Path]::GetFileNameWithoutExtension($prog))
            Write-Host "Compiling C: $src -> $out"
            & $CC "-Wall" "-Wextra" $src "-o" $out
        }
        ".cpp" {
            $out = Join-Path $BUILD_DIR ([System.IO.Path]::GetFileNameWithoutExtension($prog))
            Write-Host "Compiling C++: $src -> $out"
            & $CXX "-Wall" "-Wextra" $src "-o" $out
        }
        ".py" {
            $out = Join-Path $BUILD_DIR $prog
            Write-Host "Copying Python script: $src -> $out"
            Copy-Item $src $out -Force
        }
        ".ps1" {
            $out = Join-Path $BUILD_DIR $prog
            Write-Host "Copying PowerShell script: $src -> $out"
            Copy-Item $src $out -Force
        }
        default {
            Write-Host "Skipping $src — unsupported extension"
        }
    }
}
