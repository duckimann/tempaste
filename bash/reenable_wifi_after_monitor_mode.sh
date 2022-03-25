# How can I re-enable managed mode after monitor mode??
airmon-ng stop wlan0mon && dhclient wlan0

ifconfig wlan0 down && iwconfig wlan0 mode managed && ifconfig wlan0 up

ifconfig wlan0 down && iwconfig wlan0 mode monitor && ifconfig wlan0 up