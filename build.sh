#!/bin/bash
set -e

echo "Starting Flutter web build..."

curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.1-stable.tar.xz | tar -xJ

export PATH="$PATH:$PWD/flutter/bin"

git config --global --add safe.directory "$PWD/flutter"

flutter config --no-analytics

flutter pub get

# Use web-compatible main file
cp lib/main_web.dart lib/main.dart

flutter build web --web-renderer html --release

echo "Build completed successfully!"