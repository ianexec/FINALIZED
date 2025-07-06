#!/bin/bash
set -e

# Download monitor-quota.py
echo "📥 Downloading monitor-quota.py..."
wget -O /usr/bin/monitor-quota.py https://raw.githubusercontent.com/ianexec/FINALIZED/main/limit_handler/monitor-quota.py

# Set permission
chmod +x /usr/bin/monitor-quota.py

# Buat log file jika belum ada
touch /var/log/lunatic_quota_monitor.log
chmod 644 /var/log/lunatic_quota_monitor.log

# Buat systemd service
echo "⚙️ Membuat service systemd..."
cat > /etc/systemd/system/monitor-quota.service <<-EOF
[Unit]
Description=Auto Monitor Xray Quota & Device
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/env python3 /usr/bin/monitor-quota.py
Restart=always
RestartSec=10
StandardOutput=append:/var/log/lunatic_quota_monitor.log
StandardError=append:/var/log/lunatic_quota_monitor.log

[Install]
WantedBy=multi-user.target
EOF

# Reload dan aktifkan service
echo "🚀 Mengaktifkan service..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable monitor-quota
systemctl start monitor-quota

echo "✅ Instalasi selesai!"
echo "📄 Cek log via: tail -f /var/log/lunatic_quota_monitor.log"
echo "🔍 Cek status: systemctl status monitor-quota"
