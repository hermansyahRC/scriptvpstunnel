#!/bin/bash
# Script Auto Install Tunneling - hermansyahRC
# Support: Xray, V2Ray, Trojan, OpenVPN, WebSocket + TLS

# Update & Upgrade VPS
apt update -y && apt upgrade -y

# Install Dependencies
apt install -y nginx curl socat openssl

# Install Xray-Core
curl -sSL https://github.com/XTLS/Xray-install/raw/main/install-release.sh | bash

# Install OpenVPN
apt install -y openvpn easy-rsa

# Konfigurasi Nginx
cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80;
    server_name localhost;
    location / {
        root /var/www/html;
        index index.html;
    }
}
EOF
systemctl restart nginx

# Auto Renew SSL
apt install -y certbot python3-certbot-nginx
certbot --nginx --non-interactive --agree-tos -m admin@example.com -d yourdomain.com

# Auto Reboot VPS tiap 24 jam
echo "0 4 * * * root /sbin/reboot" >> /etc/crontab

# Selesai
echo "Instalasi selesai! Reboot VPS untuk menerapkan konfigurasi."
