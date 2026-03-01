# Android Emulator Web Streaming

Stream Android emulator ARM64 ke web browser secara real-time, mirip Appetize.io

## 🚀 Features

- ✅ Android emulator ARM64 di macOS
- ✅ Streaming real-time via web browser
- ✅ Control emulator dari browser
- ✅ Support touch input
- ✅ Low latency dengan VNC + WebSocket

## 📋 Requirements

- macOS (M1/M2 recommended untuk ARM64)
- Node.js 16+
- Python 3
- Android SDK & Emulator
- Xcode Command Line Tools

## 🛠️ Installation

### Local Development:
```bash
# Install Android SDK (via Homebrew)
brew install --cask android-commandlinetools

# Setup Android SDK
sdkmanager "platform-tools" "platforms;android-33" "system-images;android-33;google_apis;arm64-v8a"

# Setup project
chmod +x setup.sh start.sh stop.sh
./setup.sh
```

### GitHub Actions (Recommended):
```bash
# 1. Push ke GitHub
git init
git add .
git commit -m "Initial commit"
git push -u origin main

# 2. Go to Actions tab → Run workflow
# 3. Pilih "Android Emulator (Cloudflare Tunnel)"
# 4. Get public URL dari commit comments
```

📖 **Lihat [Setup Guide](docs/SETUP_GITHUB_ACTIONS.md) untuk detail lengkap**

## 🎮 Usage

### Start semua services:
```bash
./start.sh
```

### Buka browser:
```
http://localhost:3000/vnc.html
```

### Stop services:
```bash
./stop.sh
```

## 🏗️ Architecture

```
Browser (noVNC Client)
    ↓ WebSocket
Websockify (Port 6080)
    ↓ VNC Protocol
macOS Screen Sharing (Port 5900)
    ↓
Android Emulator
```

## 📱 ADB Commands

```bash
# Install APK
adb install app.apk

# Screenshot
adb exec-out screencap -p > screenshot.png

# Screen record
adb shell screenrecord /sdcard/demo.mp4

# Rotate screen
adb shell settings put system user_rotation 1
```

## 🔧 Troubleshooting

### Emulator tidak start:
```bash
# Check AVD list
emulator -list-avds

# Start manual
emulator -avd test_avd -verbose
```

### VNC tidak connect:
```bash
# Check VNC server
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent

# Test VNC
nc -zv localhost 5900
```

### Port sudah dipakai:
```bash
# Kill processes
pkill -f emulator
pkill -f websockify
lsof -ti:3000 | xargs kill
```

## 🚀 Deploy ke Production

Untuk production, gunakan:
- Nginx sebagai reverse proxy
- SSL/TLS certificate
- Authentication layer
- Docker untuk isolasi
- Load balancer untuk multiple instances

## 📝 TODO

- [ ] Multiple emulator instances
- [ ] User authentication
- [ ] APK upload & install via web
- [ ] Screen recording
- [ ] Clipboard sync
- [ ] File transfer
- [ ] WebRTC untuk latency lebih rendah

## 📄 License

MIT
