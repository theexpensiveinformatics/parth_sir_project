# install-flutter.sh
#!/bin/bash
set -e

echo "🚀 Installing Flutter 3.27.4..."

# Check if Flutter is already installed and correct version
if command -v flutter &> /dev/null; then
    CURRENT_VERSION=$(flutter --version | head -n 1 | cut -d ' ' -f 2)
    if [[ "$CURRENT_VERSION" == "3.27.4" ]]; then
        echo "✅ Flutter 3.27.4 already installed"
        flutter pub get
        exit 0
    fi
fi

echo "📥 Downloading Flutter 3.27.4..."

# Download Flutter 3.27.4 stable
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.4-stable.tar.xz"
wget -q --show-progress "$FLUTTER_URL" -O flutter.tar.xz

echo "📦 Extracting Flutter..."
tar xf flutter.tar.xz
rm flutter.tar.xz

# Add to PATH for this session
export PATH="$PATH:$PWD/flutter/bin"

echo "⚙️ Configuring Flutter..."
# Configure Flutter
flutter config --enable-web --no-analytics --no-cli-animations
flutter precache --web

echo "📋 Flutter Doctor..."
flutter doctor

echo "📦 Installing dependencies..."
flutter pub get

echo "✅ Flutter 3.27.4 installation complete!"
flutter --version