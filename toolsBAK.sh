#!/bin/bash
clear
rm -f $0
export TERM=xterm
export DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure debconf -f noninteractive 2>/dev/null

# Warna
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }

yellow "⏳ Installing dependencies..."
sleep 1

apt update -y
apt upgrade -y
apt dist-upgrade -y

apt install -y sudo curl unzip screen jq p7zip-full net-tools figlet \
  iptables iptables-persistent netfilter-persistent \
  ruby libxml-parser-perl squid nmap iftop htop zip gnupg \
  gnupg1 bc build-essential dirmngr neofetch screenfetch \
  lsof openssl openvpn easy-rsa fail2ban tmux stunnel4 dropbear socat \
  cron bash-completion ntpdate xz-utils gnupg2 dnsutils lsb-release \
  chrony libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev \
  libcap-ng-utils libselinux1-dev libcurl4-openssl-dev flex bison \
  make libnss3-tools libevent-dev xl2tpd git speedtest-cli \
  libjpeg-dev zlib1g-dev python-is-python3 python3-pip \
  msmtp at debconf-utils nginx

pip3 install --upgrade gdown

# Remove yang nggak perlu
apt-get remove --purge -y ufw firewalld exim4 unscd samba* bind9* sendmail*
apt-get autoremove -y
apt-get autoclean -y

# Gotop
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v${gotop_latest}_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb

yellow "✅ Dependencies successfully installed..."
