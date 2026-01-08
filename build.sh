#!/bin/bash
set -e

# Download and extract Flutter
curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz | tar -xJ

# Add Flutter to PATH
export PATH="$PATH:$PWD/flutter/bin"

# Fix git ownership
git config --global --add safe.directory "$PWD/flutter"

# Disable analytics
flutter config --no-analytics

# Get dependencies
flutter pub get

# Build web app
flutter build web --web-renderer canvaskit