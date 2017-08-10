#Install any missing packages needed for IoTRemote
sudo apt-get install git rsync lirc nodejs npm

#Apply config changes to activate lirc talking to the IR Shield
sudo sed -i 's/#dtoverlay=.*/dtoverlay=lirc-rpi:gpio_in_pin=18,gpio_out_pin=17/' /boot/config.txt
#Setting up the hardware.conf file to also activate lirc talking to the IR Shield
sudo sed -i 's/LIRCD_ARGS=.*/LIRCD_ARGS="--device \/dev\/lirc0 -uinput -listen"/' /etc/lirc/hardware.conf
sudo sed -i 's/DRIVER=.*/DRIVER="default"/' /etc/lirc/hardware.conf
sudo sed -i 's/DEVICE=.*/DEVICE="\/dev\/lirc0"/' /etc/lirc/hardware.conf
sudo sed -i 's/MODULES=.*/MODULES="lirc_rpi"/' /etc/lirc/hardware.conf
#Final file for configuring lirc to talk to the IR Shield, the modules files
if ! grep -q "lirc_rpi gpio_in_pin=.* gpio_out_pin=.*" /etc/modules ; then
    sudo sed -i '0,/^$/{s/^$/\nlirc_rpi gpio_in_pin=18 gpio_out_pin=17\n/}' /etc/modules
fi
if ! grep -q "lirc_dev" /etc/modules ; then
    sudo sed -i '0,/^$/{s/^$/\nlirc_dev\n/}' /etc/modules
fi

#Apply changes to rc.local so lirc start properly at boot
if ! grep -q "sudo lircd --device /dev/lirc.*" /etc/rc.local ; then
    sudo sed -i '0,/^$/{s/^$/\n# Start LIRC properly\nsudo lircd --device \/dev\/lirc0\n/}' /etc/rc.local
fi
