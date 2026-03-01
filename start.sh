#!/bin/bash

echo "🚀 Starting Android Emulator Web Streaming..."

# Start VNC server for macOS
echo "🖥️  Starting VNC server..."
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
  -activate -configure -access -on -restart -agent -privs -all 2>/dev/null

# Start websockify (VNC to WebSocket bridge)
echo "🌐 Starting websockify..."
websockify --web=./noVNC 6080 localhost:5900 &
WEBSOCKIFY_PID=$!

# Wait a bit for websockify
sleep 2

# Start Android emulator
echo "📱 Starting Android emulator..."
emulator -avd test_avd -no-audio -gpu swiftshader_indirect &
EMULATOR_PID=$!

# Wait for emulator to boot
echo "⏳ Waiting for emulator to boot..."
adb wait-for-device
sleep 10

# Start Node.js server
echo "🌍 Starting web server..."
node server.js &
SERVER_PID=$!

echo ""
echo "✅ All services started!"
echo "📱 Emulator PID: $EMULATOR_PID"
echo "🌐 Websockify PID: $WEBSOCKIFY_PID"
echo "🌍 Server PID: $SERVER_PID"
echo ""
echo "🎉 Open browser: http://localhost:3000/vnc.html"
echo ""
echo "To stop all services, run: ./stop.sh"

# Save PIDs
echo $EMULATOR_PID > .emulator.pid
echo $WEBSOCKIFY_PID > .websockify.pid
echo $SERVER_PID > .server.pid

# Keep script running
wait
