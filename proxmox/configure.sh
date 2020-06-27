#!/bin/bash

# Script to configure Proxmox VE

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root" 
   exit 1
fi

# Proxmox VE No-Subscription Repository
rm /etc/apt/sources.list.d/pve-enterprise.list
cp -f sources.list /etc/apt/sources.list
echo [+] Proxmox VE No-Subscription Repository was set