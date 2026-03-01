#!/bin/bash

echo "🛑 Stopping all services..."

# Kill processes
if [ -f .server.pid ]; then
  kill $(cat .server.pid) 2>/dev/null
  rm .server.pid
  echo "✅ Server stopped"
fi

if [ -f .websockify.pid ]; then
  kill $(cat .websockify.pid) 2>/dev/null
  rm .websockify.pid
  echo "✅ Websockify stopped"
fi

if [ -f .emulator.pid ]; then
  kill $(cat .emulator.pid) 2>/dev/null
  rm .emulator.pid
  echo "✅ Emulator stopped"
fi

# Kill any remaining emulator processes
pkill -f "emulator -avd"
pkill -f "websockify"

echo "🎉 All services stopped!"
