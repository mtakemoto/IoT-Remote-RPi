#Install any missing packages needed for IoTRemote
sudo apt-get install git rsync lirc nodejs npm

#Apply config changes to active lirc talking to the IR Shield
sudo sed -i 's/#dtoverlay=lirc-rpi/dtoverlay=lirc-rpi:gpio_in_pin=18,gpio_out_pin=17/' /boot/config.txt

#Apply changes to rc.local so lirc start properly at boot
sudo sed -i '0,/^$/{s/^$/\n# Start LIRC properly\nsudo lircd --device \/dev\/lirc0\n/}' /etc/rc.local
