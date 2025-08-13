#!/bin/bash
set -e

echo "Installing Flutter..."

# Check if Flutter is already installed
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found, installing..."

    # Download and extract Flutter
    wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
    tar xf flutter_linux_3.16.0-stable.tar.xz

    # Add to PATH
    export PATH="$PATH:$PWD/flutter/bin"

    # Configure Flutter
    flutter config --enable-web --no-analytics
    flutter precache --web
else
    echo "Flutter already installed"
fi

echo "Getting dependencies..."
flutter pub get

echo "Flutter installation complete!"