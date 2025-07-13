#!/bin/bash

# Hapus dan buat ulang direktori UDP di /usr/bin/udp
rm -rf /usr/bin/udp
mkdir -p /usr/bin/udp

# Ubah zona waktu ke GMT+7
echo "Mengatur zona waktu ke GMT+7..."
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Download udp-custom
echo "Mengunduh udp-custom..."
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ixz82G_ruRBnEEp4vLPNF2KZ1k8UfrkV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ixz82G_ruRBnEEp4vLPNF2KZ1k8UfrkV" -O /usr/bin/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /usr/bin/udp/udp-custom

# Download config.json
echo "Mengunduh config default..."
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf" -O /usr/bin/udp/config.json && rm -rf /tmp/cookies.txt
chmod 644 /usr/bin/udp/config.json

# Buat systemd service
echo "Membuat service udp-custom..."
if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/usr/bin/udp/udp-custom server
WorkingDirectory=/usr/bin/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/usr/bin/udp/udp-custom server -exclude $1
WorkingDirectory=/usr/bin/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

# Mulai dan enable service
echo "Menjalankan dan mengaktifkan service udp-custom..."
systemctl daemon-reload
systemctl start udp-custom &>/dev/null
systemctl enable udp-custom &>/dev/null

clear
echo -e "✅ UDP Custom berhasil dipasang dan berjalan di path /usr/bin/udp"
