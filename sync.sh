configs='
/boot/config.txt /etc/lirc/hardware.conf /etc/lirc/lircd.conf
/etc/lirc/lircd_original.conf /etc/lirc/lircmd.conf /etc/rc.local
/home/pi/.lirc_web_config.json'

# for config in $configs
# do
#     echo ${config/.*/.bak}
#     echo ./${config##*/}
# done

if [ "$1" == "-b" ]
then
    for config in $configs
    do
        sudo rsync -auv $config ./
    done
elif [ "$1" == "-i" ]
then
    for config in $configs
    do
        sudo rsync -auv $config ${config/.*/.bak}
        sudo rsync -auv ${config##*/} $config
    done
else
    echo "Enter '-b' to backup files into this folder or '-i' to install the files into this folder into their proper folders."
fi
