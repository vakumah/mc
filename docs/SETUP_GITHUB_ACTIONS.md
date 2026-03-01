# Setup GitHub Actions untuk Android Emulator Streaming

## 🎯 3 Workflow Options

### 1. **Simple Mode** (Tanpa Tunnel)
File: `.github/workflows/android-emulator-simple.yml`

Untuk testing basic, screenshot, run tests. Tidak bisa diakses dari luar.

```bash
# Cara pakai:
# 1. Push ke GitHub
# 2. Go to Actions tab
# 3. Run "Android Emulator (Simple)"
```

### 2. **Ngrok Tunnel** (Recommended)
File: `.github/workflows/android-emulator.yml`

Bisa diakses dari browser dengan public URL.

**Setup:**
```bash
# 1. Daftar di ngrok.com (gratis)
# 2. Get auth token dari dashboard
# 3. Add secret di GitHub repo:
#    Settings → Secrets → New repository secret
#    Name: NGROK_AUTH_TOKEN
#    Value: your_token_here
```

### 3. **Cloudflare Tunnel** (No Auth Required)
File: `.github/workflows/android-emulator-cloudflare.yml`

Paling gampang, gak perlu auth token!

```bash
# Cara pakai:
# 1. Push ke GitHub
# 2. Go to Actions tab
# 3. Run "Android Emulator (Cloudflare Tunnel)"
# 4. Check commit comments untuk URL
```

## 🚀 Quick Start

### Step 1: Push ke GitHub
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/USERNAME/REPO.git
git push -u origin main
```

### Step 2: Enable Actions
1. Go to repo Settings
2. Actions → General
3. Enable "Allow all actions"

### Step 3: Run Workflow
1. Go to Actions tab
2. Select workflow (pilih salah satu dari 3)
3. Click "Run workflow"
4. Set duration (berapa lama mau jalan)
5. Click "Run workflow"

### Step 4: Get URL
- Check commit comments
- Atau lihat di workflow logs
- Buka URL + `/vnc.html`

## 📱 Cara Install APK

Edit workflow, tambahkan di step "Run emulator":

```yaml
- name: Install APK
  run: |
    adb wait-for-device
    adb install path/to/your/app.apk
    adb shell am start -n com.your.package/.MainActivity
```

## 🎮 Controls dari Browser

Setelah buka URL:
- Click & drag = touch
- Keyboard = input text
- Scroll = scroll di emulator

## ⚠️ Limitations

1. **GitHub Actions limits:**
   - Max 6 hours per job
   - macOS runners: 10 concurrent jobs (free tier)
   - Billed per minute (tapi ada free tier)

2. **Performance:**
   - Latency tergantung internet
   - VNC = ~100-300ms delay
   - Untuk production, pakai WebRTC

3. **Security:**
   - Public URL = anyone can access
   - Untuk production, tambah authentication

## 🔧 Troubleshooting

### Emulator tidak start:
```yaml
# Tambahkan verbose logging
- name: Debug emulator
  run: |
    $ANDROID_HOME/emulator/emulator -avd test_avd -verbose
```

### Tunnel tidak dapat URL:
```yaml
# Check logs
- name: Show tunnel logs
  run: cat tunnel.log
```

### Out of space:
```yaml
# Cleanup before run
- name: Free space
  run: |
    df -h
    sudo rm -rf /usr/local/lib/android/sdk/system-images/*
```

## 💰 Cost Estimate

GitHub Actions pricing (after free tier):
- macOS runner: $0.08/minute
- 1 hour session = $4.80
- Free tier: 2000 minutes/month (private repos)

Ngrok pricing:
- Free tier: 1 agent, 40 connections/min
- Pro: $8/month

Cloudflare Tunnel:
- Free! No limits

## 🎯 Best Practices

1. **Gunakan Cloudflare Tunnel** untuk testing (gratis)
2. **Set timeout** yang reasonable (jangan 6 jam kalau cuma butuh 30 menit)
3. **Cleanup** setelah selesai
4. **Cache dependencies** untuk speed up
5. **Use matrix** untuk test multiple Android versions

## 📚 Resources

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Android Emulator Runner](https://github.com/ReactiveCircus/android-emulator-runner)
- [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)
- [ngrok Docs](https://ngrok.com/docs)
