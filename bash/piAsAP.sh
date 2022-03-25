#!/bin/bash
# Full guide: https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md
if [ -z "$1" ]; then
	echo "Syntax: [path to this script] [ssid] [password]";
	exit 1;
fi

# Install Repos
sudo apt install hostapd dnsmasq -y;
sudo systemctl unmask hostapd;
sudo systemctl enable hostapd;
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent;

# Configs
sudo echo -e "interface wlan0\n    static ip_address=192.168.4.1/24\n    nohook wpa_supplicant" >> /etc/dhcpcd.conf;
sudo echo -e "net.ipv4.ip_forward=1" >> /etc/sysctl.d/routed-ap.conf;
# sudo bash -c 'echo -e "net.ipv4.ip_forward=1" >> /etc/sysctl.d/routed-ap.conf;';

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;
sudo netfilter-persistent save;
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig;
sudo bash -c 'echo -e "interface=wlan0 # Listening interface\ndhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h # Pool of IP addresses served via DHCP\ndomain=wlan # Local wireless DNS domain\naddress=/gw.wlan/192.168.4.1 # Alias for this router" >> /etc/dnsmasq.conf';

sudo rfkill unblock wlan;
sudo echo -e "country_code=GB\ninterface=wlan0\nssid=$1\nhw_mode=g\nchannel=7\nmacaddr_acl=0\nauth_algs=1\nignore_broadcast_ssid=0\nwpa=2\nwpa_passphrase=$2\nwpa_key_mgmt=WPA-PSK\nwpa_pairwise=TKIP\nrsn_pairwise=CCMP" >> /etc/hostapd/hostapd.conf;
sudo systemctl reboot;