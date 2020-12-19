#!/bin/bash
#                               Root Check Does Not Function!
#if (whoami != root)
#then 
#    echo "Please Run As root"
#    exit
#else

#                               colors
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

set -e
trap ctrl_c INT

function ctrl_c() {
    clear
    echo -e $RED"EXITING"
    sleep 0.1
    echo -e $GREEN"EXITING"
    sleep 0.1
    echo -e $BLUE"EXITING"
    sleep 0.1
    exit
}

clear
echo -e "$RED __  __        _  _    _  _____            _ \n|  \/  | _  _ | || |_ (_)|_   _| ___  ___ | |\n| |\/| || || || ||  _|| |  | |  / _ \/ _ \| |\n|_|  |_| \_._||_| \__||_|  |_|  \___/\___/|_|\n\nidubbzwife\n"
sleep 0.25
clear
echo -e "$GREEN __  __        _  _    _  _____            _ \n|  \/  | _  _ | || |_ (_)|_   _| ___  ___ | |\n| |\/| || || || ||  _|| |  | |  / _ \/ _ \| |\n|_|  |_| \_._||_| \__||_|  |_|  \___/\___/|_|\n\nidubbzwife\n"
sleep 0.25
clear
echo -e "$BLUE __  __        _  _    _  _____            _ \n|  \/  | _  _ | || |_ (_)|_   _| ___  ___ | |\n| |\/| || || || ||  _|| |  | |  / _ \/ _ \| |\n|_|  |_| \_._||_| \__||_|  |_|  \___/\___/|_|\n\nidubbzwife\n"
sleep 0.25
clear
echo -e "$NC __  __        _  _    _  _____            _ \n|  \/  | _  _ | || |_ (_)|_   _| ___  ___ | |\n| |\/| || || || ||  _|| |  | |  / _ \/ _ \| |\n|_|  |_| \_._||_| \__||_|  |_|  \___/\___/|_|\n\nidubbzwife\n"
sleep 0.25

echo -e $NC"what do you wish to do?\n1 monitor mode\n2 managed mode\n3 change  mac adress\n4 check a hash\n5 Arp Scan\n6 nmap default scans"
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
            echo -e "Hashes Match."
            sleep 0.5
            clear
            echo -e $RED"EXITING"
            sleep 0.1
            echo -e $GREEN"EXITING"
            sleep 0.1
            echo -e $BLUE"EXITING"
            sleep 0.1
            exit
        else
        echo "Hashes Don't Match"
        fi
elif [ $MODE == 5 ]
then
    sudo arp-scan -I wlan0 -l -g
elif [ $MODE == 6 ]
then
    clear
    echo -e "nmap presets\n1 Intense scan\n2 Intense scan plus UDP\n3 Intense scan, all TCP ports\n4 Intense scan, no ping\n5 Ping scan\n6 Quick scan\n7 Quick scan plus\n8 Quick scan plus\n9 Quick traceroute\n10 Regular scan\n11 Slow comprehensive scan"
    read SCAN
    clear
    echo "Type Target Adress"
    read TARGET
    if [ $SCAN == 1 ]
    then
        sudo nmap -T4 -A -v $TARGET
    elif [ $SCAN == 2 ]
    then
        sudo nmap -sS -sU -T4 -A -v $TARGET
    elif [ $SCAN == 3 ]
    then
        sudo nmap -p 1-65535 -T4 -A -v $TARGET
    elif [ $SCAN == 4 ]
    then
        sudo nmap -T4 -A -v -Pn $TARGET
    elif [ $SCAN == 5 ]
    then
        sudo nmap -sn $TARGET
    elif [ $SCAN == 6 ]
    then
        sudo nmap -sn $TARGET
    elif [ $SCAN == 7 ]
    then
        sudo nmap -T4 -F $TARGET
    elif [ $SCAN == 8 ]
    then
        sudo nmap -sV -T4 -O -F –version-light $TARGET
    elif [ $SCAN == 9 ]
    then
        sudo nmap -sn –traceroute $TARGET
    elif [ $SCAN == 10 ]
    then
        sudo nmap $TARGET
    elif [ $SCAN == 11 ]
    then
        sudo nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 –script "default or (discovery and safe)" $TARGET
    fi

fi
