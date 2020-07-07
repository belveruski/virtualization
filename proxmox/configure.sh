#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Script to configure Proxmox VE

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
    echo "[-] This script must be run as root"
    exit 1
fi

# Proxmox VE No-Subscription Repository
echo [+] Removing the Proxmox VE Enterprise Repository...
ls /etc/apt/sources.list.d/pve-enterprise.list &> /dev/null
if [ $? -ne 0 ]
then
    echo [+] Proxmox VE No-Subscription Repository was already set.
else
    rm /etc/apt/sources.list.d/pve-enterprise.list
    cp -f sources.list /etc/apt/sources.list
    echo [+] Proxmox VE No-Subscription Repository was set.
fi

# Update Proxmox VE
echo [+] Updating Proxmox VE...
apt-get update -qq && apt-get -qq -y full-upgrade &>/dev/null
echo [+] Promox VE is up to date.

# Remove the subscription notice on the web panel
echo [+] Removing the subscription notice on the web panel...
sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
echo [+] The subscription notice on the web panel was removed.

# Fix Perl warning
echo [+] Fixing Perl warning on your remote SSH terminal session
sed -i 's/.*AcceptEnv LANG LC_\*.*/AcceptEnv LANG LC_PVE_* # Fix for perl: warning: Setting locale failed./' /etc/ssh/sshd_config
service ssh reload
echo [+] To fix the problem, reconnect to a new SSH terminal session.