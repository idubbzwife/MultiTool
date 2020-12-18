#!/bin/bash
#                               Root Check Does Not Function!
#if (whoami != root)
#then 
#    echo "Please Run As root"
#    exit
#else
clear
echo -e " __  __        _  _    _  _____            _ \n|  \/  | _  _ | || |_ (_)|_   _| ___  ___ | |\n| |\/| || || || ||  _|| |  | |  / _ \/ _ \| |\n|_|  |_| \_._||_| \__||_|  |_|  \___/\___/|_|\n\n"
echo -e "what do you wish to do?\n1 monitor mode\n2 managed mode\n3 change  mac adress\n4 check a hash\n5 Arp Scan"
read MODE
if [ $MODE == 1 ]
then
    sudo airmon-ng start wlan0
    sudo ifconfig wlan0mon down
    sudo macchanger -r wlan0mon
    sudo ifconfig wlan0mon up
elif [ $MODE == 2 ]
then
    sudo airmon-ng stop wlan0mon
    sudo ifconfig wlan0 down
    sudo macchanger -r wlan0
    sudo ifconfig wlan0 up
elif [ $MODE == 3 ]
then
    echo "wireless card name:"
    read CARD
    sudo ifconfig $CARD down
    sudo macchanger -r $CARD
    sudo ifconfig $CARD up
elif [ $MODE == 4 ]
then
    clear
    echo -e "What type of hash?\n1 sha256\n2 sha1\n3 md5"
    read HASH
    clear
    echo "File Location?"
    read LOC
    clear
    if [ $HASH == 1 ]
    then
        SUM=sha256sum
    fi
    if [ $HASH == 2 ]
    then
        SUM=sha1sum
    fi
    if [ $HASH == 3 ]
    then
        SUM=md5sum
    fi
        my_array=( $($SUM $LOC) )
        echo "current hash ${my_array[0]}"
        echo "Enter Hash To Check"
        read RXHASH
        if [ "${my_array[0]}" == "$RXHASH" ]
        then
            echo "Hashes Match."
        else
        echo "Hashes Don't Match"
        fi
fi
if [ $MODE == 5 ]
then
    sudo arp-scan -I wlan0 -l -g
    fi
 




fi
