#!/bin/sh
set -e

echo "=========================================="
echo " Keepsy Server - Railway Root Launcher    "
echo "=========================================="

if [ -d "server" ]; then
    cd server
fi

if [ -f "./start.sh" ]; then
    exec ./start.sh
fi

if [ ! -f "./main" ]; then
    echo "[*] Building server binary..."
    if command -v go >/dev/null 2>&1; then
        go build -o main ./cmd/server/main.go
    else
        echo "[✗] Error: Go compiler not available in current environment." >&2
        exit 1
    fi
fi

chmod +x ./main
echo "[✓] Launching Keepsy server on port ${PORT:-8080}..."
exec ./main
