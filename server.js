const express = require('express');
const { spawn } = require('child_process');
const path = require('path');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.static('public'));
app.use('/novnc', express.static('noVNC'));

const PORT = process.env.PORT || 3000;
const VNC_PORT = 5900;

// Endpoint untuk start emulator
app.post('/api/start-emulator', (req, res) => {
  console.log('Starting Android emulator...');
  
  const emulator = spawn('emulator', [
    '-avd', 'test_avd',
    '-no-audio',
    '-gpu', 'swiftshader_indirect',
    '-no-snapshot-load',
    '-no-boot-anim'
  ]);

  emulator.stdout.on('data', (data) => {
    console.log(`Emulator: ${data}`);
  });

  emulator.stderr.on('data', (data) => {
    console.error(`Emulator Error: ${data}`);
  });

  res.json({ status: 'starting', message: 'Emulator is booting up...' });
});

// Endpoint untuk check status
app.get('/api/status', (req, res) => {
  const adb = spawn('adb', ['devices']);
  let output = '';

  adb.stdout.on('data', (data) => {
    output += data.toString();
  });

  adb.on('close', () => {
    const isRunning = output.includes('emulator') && output.includes('device');
    res.json({ 
      running: isRunning,
      devices: output 
    });
  });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`VNC viewer will be available at http://localhost:${PORT}/vnc.html`);
});
