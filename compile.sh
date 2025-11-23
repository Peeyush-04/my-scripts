#!/bin/sh

# Compiler/interpreters
CC=gcc
CXX=g++
PYTHON=python3

# Directories
BUILD_DIR="build"
SRC_DIR="src"

# Read programs from 'programs' file
if [ ! -f programs ]; then
    echo "Error: 'programs' file not found."
    exit 1
fi

PROGRAMS=$(grep -v '^\s*$' programs)  # ignore empty lines

# Create build directory
mkdir -p "$BUILD_DIR"

# Compile/run programs
for prog in $PROGRAMS; do
    src="$SRC_DIR/$prog"

    if [ ! -f "$src" ]; then
        echo "Skipping $src — file not found"
        continue
    fi

    # Determine action by file extension
    ext="${prog##*.}"

    case "$ext" in
        c)
            out="$BUILD_DIR/${prog%.c}"
            echo "Compiling C: $src -> $out"
            $CC -Wall -Wextra "$src" -o "$out"
            ;;
        cpp)
            out="$BUILD_DIR/${prog%.cpp}"
            echo "Compiling C++: $src -> $out"
            $CXX -Wall -Wextra "$src" -o "$out"
            ;;
        py)
            out="$BUILD_DIR/${prog%.py}.py"
            echo "Copying Python script: $src -> $out"
            cp "$src" "$out"
            ;;
        ps1)
            # Copy PowerShell scripts to build for organization
            out="$BUILD_DIR/$prog"
            echo "Copying PowerShell script: $src -> $out"
            cp "$src" "$out"
            ;;
        *)
            echo "Skipping $src — unsupported extension"
            ;;
    esac
done

# Clean option
if [ "$1" = "clean" ]; then
    echo "Cleaning build directory..."
    rm -rf "$BUILD_DIR"
fi
