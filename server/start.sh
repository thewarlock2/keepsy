#!/bin/sh
set -e

# Navigate to the directory containing this script
cd "$(dirname "$0")"

echo "=========================================="
echo " Keepsy Server - Railway Startup Script   "
echo "=========================================="

# Check for migrations directory
if [ -d "./migrations" ]; then
    echo "[✓] Migrations directory found at $(pwd)/migrations"
else
    echo "[!] Warning: migrations directory not found in $(pwd)!" >&2
fi

# Build binary if not already built
if [ ! -f "./main" ]; then
    echo "[*] './main' binary not found. Compiling cmd/server/main.go..."
    if command -v go >/dev/null 2>&1; then
        go build -o main ./cmd/server/main.go
        echo "[✓] Compilation successful."
    else
        echo "[✗] Error: Go compiler not found and './main' binary does not exist." >&2
        exit 1
    fi
fi

chmod +x ./main

echo "[✓] Starting server on port ${PORT:-8080}..."
exec ./main
