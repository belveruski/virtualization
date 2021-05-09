#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Script to configure Proxmox VE

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
    echo "[-] This script must be run as root"
    exit 1
fi

# Proxmox VE No-Subscription Repository
echo "[i] Removing the Proxmox VE Enterprise Repository..."
ls /etc/apt/sources.list.d/pve-enterprise.list &> /dev/null
if [ $? -ne 0 ]
then
    echo "[+] Proxmox VE No-Subscription Repository was already set."
else
    rm /etc/apt/sources.list.d/pve-enterprise.list
    #cp -f sources.list /etc/apt/sources.list
    cat > /etc/apt/sources.list <<EOL
deb http://ftp.debian.org/debian buster main contrib
deb http://ftp.debian.org/debian buster-updates main contrib

# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve buster pve-no-subscription

# security updates
deb http://security.debian.org/debian-security buster/updates main contrib
EOL
    echo "[+] Proxmox VE No-Subscription Repository was set."
fi

# Update Proxmox VE
echo [+] Updating Proxmox VE...
apt-get update -qq && apt-get -qq -y full-upgrade &>/dev/null
echo [+] Promox VE is up to date.

# Remove the subscription notice on the web panel
echo "[i] Removing the subscription notice on the web panel..."
sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
echo "[+] The subscription notice on the web panel was removed."

# Fix Perl warning
# echo [+] Fixing Perl warning on your remote SSH terminal session
sed -i 's/.*AcceptEnv LANG LC_\*.*/AcceptEnv LANG LC_PVE_* # Fix for perl: warning: Setting locale failed./' /etc/ssh/sshd_config
systemctl restart sshd
echo "[+] To fix the problem, reconnect to a new SSH terminal session."

# Enable Dark Mode
bash <(curl -s https://raw.githubusercontent.com/Weilbyte/PVEDiscordDark/master/PVEDiscordDark.sh ) install