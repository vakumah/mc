#!/bin/bash

echo "🚀 Setting up Android Emulator Web Streaming..."

# Install dependencies
echo "📦 Installing Node.js dependencies..."
npm install

# Clone noVNC
if [ ! -d "noVNC" ]; then
  echo "📥 Downloading noVNC..."
  git clone https://github.com/novnc/noVNC.git
  cd noVNC
  git checkout v1.4.0
  cd ..
fi

# Install websockify
echo "🔧 Installing websockify..."
pip3 install websockify

# Create Android AVD if not exists
echo "📱 Checking Android AVD..."
avdmanager list avd | grep -q "test_avd"
if [ $? -ne 0 ]; then
  echo "Creating Android AVD (ARM64)..."
  echo "no" | avdmanager create avd \
    -n test_avd \
    -k "system-images;android-33;google_apis;arm64-v8a" \
    -d "pixel_6"
fi

# Create public directory
mkdir -p public

echo "✅ Setup complete!"
echo ""
echo "To start the service:"
echo "1. Run: ./start.sh"
echo "2. Open browser: http://localhost:3000/vnc.html"
