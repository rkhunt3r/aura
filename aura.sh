#!/bin/bash
# AURA - An Easy User Interface For Pentesting Tools
#
config_file=config/settings.conf
source $config_file
#

f_toolscheck()
{
    
info="\n\e[0m[\e[91m!\e[0m] REQUIES TOOL NOT FOUND! INSTALL IT USING INSTALL.SH..."
    
    command -v aircrack-ng >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v macchanger >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v speedtest-cli >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v figlet >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v l2ping >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v ruby >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v lolcat >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v unzip >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v curl >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    command -v wget >/dev/null 2>&1 || { printf >&2 "\e[0m$info\n "; exit; }
    
}

banner()
{
    if [[ $cout -eq 1 ]]
    then
        f_banner | lolcat -a -d 3 -F 0.1
        cout=0
    else
        f_banner
    fi
}


f_banner()
{
clear
printf '\e[92m
 8888b.  888  888 888d888 8888b.      
    "88b 888  888 888P"      "88b 
.d888888 888  888 888    .d888888  
888  888 Y88b 888 888    888  888 
"Y888888  "Y88888 888    "Y888888 v0.5\n\e[0m'
}

auramenu()
{
    banner
    printf "\nMENU\n\e[0m--------------+ WIFI +--------------"
printf "
(1) DEAUTH WI-FI/CLIENT 
(2) SCAN FOR WI-FI/CLIENT
(3) MONITOR MODE MENU
(4) CHANGE MAC ADDRES
(5) SHOW WIRELESS IFACES
(6) CRACK CAPTURE\n"
printf "\e[0m--------------+ SCAN +--------------"
printf "
(7) SCAN NETWORK
(8) SCAN WEBSITE
"
printf "\e[0m---------------+ BT +---------------"
printf "
(9) BLUETOOTH POD
(10) BLUETOOTH SCAN
"
printf "\e[0m------------------------------------"
printf "
(11) SETTINGS
"
printf "\e[0m------------------------------------"
printf "
(12) EXIT\n
" 

read -p "SELECT: " auramenu
case $auramenu in
    
    1) aurajammer ;;
    
    2) aurascanner ;;
    
    3) mmmode ;;
    
    4) mac ;;
    
    5) ifaces;;
    
    6) crackcap ;;
    
    7) net_scan;;

    8) scan_site;;
    
    9) bt_pod ;;
    
    10) bt_scan ;;
    
    11) settings ;;
    
    12) exit ; clear ;;
    
    *) printf "$red"; exit;;
    esac
}

aurajammer()
{
    banner
    printf "\nDEAUTH\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) DEAUTH WI-FI 
(2) DEAUTH CLIENT\n"
    printf "\e[0m--------------------------" 
printf "
(3) BACK\n
"
read -p "SELECT: " deauth
case $deauth in
    
    1) f_wifi ;;
    
    2) f_client ;;
    
    3) auramenu ;;
    
    *) printf "$red"; exit;;
    esac
}

f_wifi()
{
    banner
    printf "\n"
    read -p "WI-FI BSSID: " BSSID
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read  -p "DEAUTH $BSSID? (Y/N): " yesorno
    case $yesorno in
        [yY][eE][sS]|[yY])
            printf "$inf STARTING ATTACK...\n"
            sleep 1
            aireplay-ng -0 0 -a $BSSID $iface --ignore-negative-one
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..."
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}

f_client()
{
    banner
    printf "\e[0m\n"
    read -p "WI-FI BSSID: " BSSID
    read -p "CLIENT BSSID: " CLIENT
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read -p "DEAUTH $BSSID? (Y/N): " yesorno
    printf "\e[93m\n"
    case $yesorno in
        [yY][eE][sS]|[yY])
            printf "$inf STARTING ATTACK...\n"
            sleep 1
            aireplay-ng -0 0 -b $BSSID -c $CLIENT $iface --ignore-negative-one
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..."
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}


aurascanner()
{
    banner
    printf "\nWIFI SCAN\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) SCAN FOR WI-FI
(2) SCAN FOR CLIENTS\n"
    printf "\e[0m--------------------------" 
    printf "
(3) BACK\n
"
read -p "SELECT: " select
    case $select in
    
    1) f_apscan ;;
    
    2) f_cliscan ;;
    
    3) auramenu ;;
    
    *) printf "$red"; exit;;
    esac
}

f_apscan()
{
    banner
    printf "$quest "
    read -p "SAVE LOGS? (Y/N): " logs
    case $logs in
        [yY][eE][sS]|[yY])
            read -p "CAPTURE NAME: " cap
            read -e -i $iface -p "INTERFACE: " iface
            iface="${input:-$iface}"
            printf "$quest "
            read  -p "START SCAN? (Y/N): " yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                    printf "\e[93m"
                    printf "$inf STARTING SCAN...\e[0m\n"
                    sleep 1
                    airodump-ng -w $cap --output-format csv $iface
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red"
                exit
                ;;
            esac
            ;;
        [nN][oO]|[nN])
            read -e -i $iface -p "INTERFACE: " iface
            iface="${input:-$iface}"
            printf "$quest "
            read  -p "START SCAN? (Y/N): " yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                    printf "$inf STARTING SCAN...\e[0m\n"
                    airodump-ng $iface
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."     
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red"
                exit
                ;;
            esac
            ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}

f_cliscan()
{
    banner
    printf "$quest "
    read  -p "SAVE LOGS? (Y/N): " logs
    case $logs in
        [yY][eE][sS]|[yY])
            read -p "CAPTURE NAME: " cap
            read -p "WI-FI BSSID: " bssid
            read -e -i $iface -p "INTERFACE: " iface
            iface="${input:-$iface}"
            printf "$quest "
            read  -p "START SCAN? (Y/N): " yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                    printf "\e[93m"
                    printf "$inf STARTING SCAN...\e[0m\n"
                    sleep 1
                    airodump-ng --bssid $bssid -w $cap --output-format csv $iface
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red"
                exit
                ;;
            esac
            ;;
        [nN][oO]|[nN])
            read -p "WI-FI BSSID: " bssid
            read -p "INTERFACE: " iface
            printf "$quest "
            read  -p "START SCAN? (Y/N): " yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                    printf "$inf STARTING SCAN...\e[0m\n"
                    sleep 1
                    airodump-ng --bssid $bssid $iface
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."     
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red"
                exit
                ;;
            esac
            ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}

mmmode()
{
    banner
    printf "\nMONITOR MODE\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) ENABLE MONITOR MODE
(2) DISABLE MONITOR MODE\n"
printf "\e[0m--------------------------" 
printf "
(3) BACK\n
"
read -p "SELECT: " select
    case $select in
    
    1) mmode ;;
    
    2) mmodeoff ;;
    
    3) auramenu ;;
    
    *) printf "$red"; exit;;
    esac
}





mmode()
{
    banner
    printf "\e[0m\n"
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read  -p "YOU WANT TO CHOOSE A CHANNEL? (Y/N): " quest
    case $quest in 
        [yY][eE][sS]|[yY])
            read -p "CHANNEL: " chnl
            printf '\n\e[0m[\e[93m?\e[0m] '
            read  -p "ENABLE MONITOR MODE ON $iface? (Y/N): " t
            case $t in
                [yY][eE][sS]|[yY])
                    printf "$inf ENABLING MONITOR MODE...\n"
                    sleep 1
                    airmon-ng check kill
                    airmon-ng start $iface $chnl
                    sleep 1.5
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red"
                exit
                ;;
            esac
            ;;
        [nN][oO]|[nN])
            printf "\n\e[0m[\e[93m?\e[0m] "
            read  -p "ENABLE MONITOR MODE ON $iface? (y/n): " t
            case $t in
                [yY][eE][sS]|[yY])
                    printf "$inf ENABLING MONITOR MODE...\n"
                    sleep 1
                    airmon-ng check kill
                    airmon-ng start $iface 
                    sleep 1.5
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red"
                exit
                ;;
            esac
            ;;
        *)
        printf "$red"
        exit
        ;;
    esac
        
}

mmodeoff()
{
    banner
    printf "\e[0m\n"
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read  -p "START NETWORK-MANAGER SERVICE AFTER DISABLING MONITOR MODE? (Y/N): " networkm
    printf "\n"
    case $networkm in
        [yY][eE][sS]|[yY])
            printf "$quest "
            read  -p "DISABLE MONITOR MODE ON $iface? (Y/N): " yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                printf "$inf DISABLING MONITOR MODE...\n"
                sleep 1
                printf "\e[0m"
                airmon-ng check kill
                airmon-ng stop $iface
                printf "$inf STARTING NETWORK-MANAGER SERVICE...\n\e[0m"
                sleep 1.2
                service network-manager start
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                [nN][oO]|[nN])
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                *)
                printf "$red"
                exit
                ;;
            esac
        ;;
        [nN][oO]|[nN])
           printf "$quest "
           read  -p "DISABLE MONITOR MODE ON $iface? (Y/N): "                yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                printf "$inf DISABLING MONITOR MODE...\n"
                sleep 1
                printf "\e[0m"
                airmon-ng check kill
                airmon-ng stop $iface
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                [nN][oO]|[nN])
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                *)
                printf "$red"
                exit
                ;;
            esac
        ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}

mac()
{
    banner
    printf "\nMAC CHANGER\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) SET CUSTOM MAC ADDRES
(2) SET RANDOM MAC ADDRES
(3) RESET MAC ADDRES\n"
printf "\e[0m--------------------------" 
printf "
(4) BACK\n
"
read -p "SELECT: " select
case $select in

1) mac1 ;;

2) mac2;;

3) mac3;;

4) auramenu;;

*) printf "$red"; exit;;
esac
}

mac1()
{
    banner
    printf "\e[0m\n"
    read -p "MAC ADDRES: " MAC
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read  -p "CHANGE MAC ADDRES ON $iface? (Y/N): " questyorn
    printf "\n"
    case $questyorn in
        [yY][eE][sS]|[yY])
            printf "\e[0m"
            ifconfig $iface down
            macchanger -m $MAC $iface
            ifconfig $iface up
            printf "$inf "
            read -p "DONE! PRESS [ENTER] TO BACK..." variable
            auramenu
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..."
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red"
        ;;
    esac
}
    
mac2()
{
    banner
    printf "\e[0m\n"
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read  -p "CHANGE MAC ADDRES ON $iface? (Y/N): " questyorn
    printf "\n"
    case $questyorn in
        [yY][eE][sS]|[yY])
            printf "\e[0m"
            ifconfig $iface down
            macchanger -a $iface
            ifconfig $iface up
            printf "$inf "
            read -p "DONE! PRESS [ENTER] TO BACK..." variable
            auramenu
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..."
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red"
        ;;
    esac
}

mac3()
{
    banner
    printf "\e[0m\n"
    read -e -i $iface -p "INTERFACE: " iface
    iface="${input:-$iface}"
    printf "$quest "
    read  -p "RESET MAC ADDRES ON $iface? (Y/N): " questyorn
    printf "\n"
    case $questyorn in
        [yY][eE][sS]|[yY])
            printf "\e[0m"
            ifconfig $iface down
            macchanger -p $iface
            ifconfig $iface up
            printf "$inf "
            read -p"DONE! PRESS [ENTER] TO BACK..." variable
            auramenu
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..." 
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red"
        ;;
    esac
}

ispeed()
{
    banner
    printf "\e[0m\n"
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        printf "$inf PLEASE WAIT...\n\n"
        speedtest-cli --simple
    else
        printf "\e[0m\n"
        printf "\e[93m-------------------\n||$nonet\e[93m||\n-------------------\n"
    fi
    printf "$inf "
    read -p "PRESS [ENTER] TO BACK..." variable
    auramenu
}

ifaces()
{
    banner
    
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    printf "\e[93m----------------------------\n||\e[96mIP ADDRES:\e[92m $(curl -s ifconfig.me)\e[93m||\n----------------------------\n"
        else
    printf "\e[0m\n"
    printf "\e[93m-------------------\n||$nonet\e[93m||\n-------------------\n"
        fi
    printf "\e[93mLIST OF AVAILABLE INTERFACES:\e[0m\n"
    printf "\n"
    ip -o link | grep ether | awk '{ print $2" "$17 }'
    printf "$inf "
    read -p "PRESS [ENTER] TO BACK..." variable
    auramenu
    
    
}

rootcheck()
{
if [[ $EUID -ne 0 ]]; then
   echo "\n\e[0m[\e[91m!\e[0m] THIS SCRIPT MUST BE RUN AS ROOT! ABORTING...\n" 
   exit 1
fi
}

settings()
{
    banner
    printf "\nSETTINGS\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) CHECK INTERNET SPEED
(2) THE CLEANER
(3) UPDATE SCRIPT
(4) EDIT CONFIG
"
printf "\e[0m--------------------------" 
printf "
(5) BACK\n
"
read -p "SELECT: " set
case $set in

1) ispeed;;
2) cleanram;;
3) f_update;;
4) edit_set;;
5) auramenu;;
*) printf "$red"; exit;;
esac

}

cleanram()
{
banner
printf "\e[0m\n\e[93mTHE CLEANER\e[92m\n*DELETE ALL LOGS SAVED IN AURA FOLDER\n*CLEAR YOU RAM MEMORY\n*CLEAR SWAP MEMORY"
printf "$quest "
read  -p "RUN CLEANER? (Y/N): " questyorn
printf "\n"
case $questyorn in
    [yY][eE][sS]|[yY])
            printf "$inf CLEANING..."
            printf "\e[0m\n"
            sync; echo 3 > /proc/sys/vm/drop_caches 
            rm -f *.csv 
            swapoff -a && swapon -a
            printf "$inf "
            read -p"DONE! PRESS [ENTER] TO BACK..." variable
            auramenu
            ;;
    [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..." 
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red";exit
        ;;
esac
}

f_update()
{
    
banner
printf "$quest "
read  -p "UPDATE SCRIPT? (Y/N): " questyorn
    printf "\n"
    case $questyorn in
        [yY][eE][sS]|[yY])
        
        
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
            printf "$inf DOWNLOADING... THIS CAN TAKE A WHILE.\e[0m\n"
            sleep 1
            printf "\e[0m"
            banner
            printf "$inf UPDATING...\e[0m\n\n"
            sleep 1
            rm aura.sh
            rm install.sh
            wget https://raw.githubusercontent.com/rkhunt3r/aura/master/install.sh
            wget https://raw.githubusercontent.com/rkhunt3r/aura/master/aura.sh
            chmod +x aura.sh
            chmod +x install.sh
            printf "$inf "
            read -p "DONE! PRESS [ENTER]..." variable
            bash install.sh
            bash aura.sh
        else
            printf "\e[93m-------------------\n||$nonet\e[93m||\n-------------------\n"
         .  printf "$inf "
            read -p "press [ENTER] to back" variable
            auramenu
        fi
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..."
            sleep 1.2
            auramenu
            ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}

crackcap()
{
    
if [ -e rockyou.txt ]
then
    crackmenu
else
    crackap2
fi
    
}

crackmenu()
{
    banner
    printf "\nCRACK\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) CRACK WEP CAPTURE
(2) CRACK WPA/WPA2 CAPTURE\n"
printf "\e[0m--------------------------" 
printf "
(3) BACK

"
read -p "SELECT: " sel
case $sel in
1) wep_crack ;;
2) wpa_crack ;;
3) auramenu ;;
*) printf "$red";exit ;;
esac
}


wep_crack()
{
    
    banner
    printf "\e[0m\n"
    read -p "TARGET CAPTURE BSSID: " bssid
    read -p "CAPTURE FILE (.cap): " capture
    printf "$quest "
    read -p "USE CUSTOM WORDLIST OR ROCKYOU WORDLIST? (c/r): " quest
    case $quest in
        [cC][uU][sS][tT][oO][mM]|[cC])
            printf "\e[0m"
            read -p "WORDLIST (.txt): " wordlist
            printf "\n\e[0m[\e[93m?\e[0m] "
            read -p "CRACK $capture? (y/n): " capturequest
            case $capturequest in
                [yY][eE][sS]|[yY])
                    printf "$inf CRACKING CAPTURE...\n\e[0m"
                    sleep 1
                    aircrack-ng -a1 -b $bssid -w $wordlist $capture
                    printf "$inf "
                    read -p "DONE! PRESS [ENTER] TO BACK..." variable
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red";exit
                ;;
            esac
            ;;
        [rR][oO][cC][kK][yY][oO][uU]|[rR])
                if [ -e rockyou.txt ]
                then 
                    check1
                else 
                    crackap2
                fi
                ;;
        *)
        printf "";exit
        ;;
    esac
}

wpa_crack(){
    
    banner
    printf "\e[0m\n"
    read -p "TARGET CAPTURE BSSID: " bssid
    read -p "CAPTURE FILE (.cap): " capture
    printf "$quest "
    read -p "USE CUSTOM WORDLIST OR ROCKYOU WORDLIST? (c/r): " quest
    case $quest in
        [cC][uU][sS][tT][oO][mM]|[cC])
            printf "\e[0m"
            read -p "WORDLIST (.txt): " wordlist
            printf "\n\e[0m[\e[93m?\e[0m] "
            read -p "CRACK $capture? (y/n): " capturequest
            case $capturequest in
                [yY][eE][sS]|[yY])
                    printf "$inf CRACKING CAPTURE...\n\e[0m"
                    sleep 1
                    aircrack-ng -a2 -b $bssid -w $wordlist $capture
                    printf "$inf "
                    read -p "DONE! PRESS [ENTER] TO BACK..." variable
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red";exit
                ;;
            esac
            ;;
        [rR][oO][cC][kK][yY][oO][uU]|[rR])
            if [ -e ''"rockyou"''.txt ]
            then
                check2
            else
                crackap2
            fi
            ;;
        *) printf "$red";exit
        ;;
    esac
}
wpa_crack(){
    
    banner
    printf "\e[0m\n"
    read -p "TARGET CAPTURE BSSID: " bssid
    read -p "CAPTURE FILE (.cap): " capture
    printf "$quest "
    read -p "USE CUSTOM WORDLIST OR ROCKYOU WORDLIST? (c/r): " quest
    case $quest in
        [cC][uU][sS][tT][oO][mM]|[cC])
            printf "\e[0m"
            read -p "WORDLIST (.txt): " wordlist
            printf "\n\e[0m[\e[93m?\e[0m] "
            read -p "CRACK $capture? (y/n): " capturequest
            case $capturequest in
                [yY][eE][sS]|[yY])
                    printf "$inf CRACKING CAPTURE...\n\e[0m"
                    sleep 1
                    aircrack-ng -a2 -b $bssid -w $wordlist $capture
                    printf "$inf "
                    read -p "DONE! PRESS [ENTER] TO BACK..." variable
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red";exit
                ;;
            esac
            ;;
        [rR][oO][cC][kK][yY][oO][uU]|[rR])
            if [ -e ''"rockyou"''.txt ]
            then
                check2
            else
                crackap2
            fi
            ;;
        *) printf "$red";exit
        ;;
    esac
}

crackap2()
{
    banner
    printf "$inf ROCKYOU.TXT NOT FOUND IN AURA FOLDER!\n$inf YOU CAN CONTINUE WITHOUT IT\n\e[0m"
    printf "$quest "
    read -p "DOWNLOAD ROCKYOU WORLDLIST (134MB) (y/n): " download
    case $download in
        [yY][eE][sS]|[yY])
        if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
            printf "$inf DOWNLOADING... THIS CAN TAKE A WHILE.\e[0m\n"
            sleep 1
            curl -L -o rockyou.txt https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
            printf "$inf DONE!\e[0m"
            sleep 1.2
            crackmenu
        else
            printf "\e[93m-------------------\n||$nonet\e[93m||\n-------------------\n"
            printf "$inf "
            read -p "press [ENTER] to back" variable
            auramenu
        fi
            ;;
        [nN][oO]|[nN])
            crackmenu
            ;;
        *)
        printf "$red";exit
        ;;
    esac
}


check1()
{
            printf "\n\e[0m[\e[93m?\e[0m] "
            read -p "CRACK $capture? (y/n): " capturequest
            case $capturequest in
                [yY][eE][sS]|[yY])
                    printf "$inf CRACKING CAPTURE...\n\e[0m"
                    sleep 1
                    aircrack-ng -a1 -b $bssid -w rockyou.txt $capture
                    printf "$inf "
                    read -p "DONE! PRESS [ENTER] TO BACK..." variable
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red";exit
                ;;
            esac
}

check2()
{
            printf "\n\e[0m[\e[93m?\e[0m] "
            read -p "CRACK $capture? (y/n): " capturequest
            case $capturequest in
                [yY][eE][sS]|[yY])
                    printf "$inf CRACKING CAPTURE...\n\e[0m"
                    sleep 1
                    aircrack-ng -a2 -b $bssid -w rockyou.txt $capture
                    printf "$inf "
                    read -p "DONE! PRESS [ENTER] TO BACK..." variable
                    auramenu
                    ;;
                [nN][oO]|[nN])
                    printf "$inf BACKING TO MENU..."
                    sleep 1.2
                    auramenu
                    ;;
                *)
                printf "$red";exit
                ;;
            esac
}

bt_pod()
{
    banner
    printf "\e[0m\n"
    read -e -i $device -p "INTERFACE: " device
    device="${input:-$device}"
    read -p "TARGET: " target
    printf '\n\e[0m[\e[93m?\e[0m] '
    read -p "START ATTACK? (Y/N): " logs
    case $logs in
        [yY][eE][sS]|[yY])
            printf "$inf STARTING BT PING OF DEATH ATTACK...\n"
            hciconfig $device up
            l2ping -i $device -s 600 -f $target 
            printf "$inf "
            read -p "press [ENTER] to back" variable
            auramenu
            ;;
        [nN][oO]|[nN])
            printf "$inf BACKING TO MENU..."
            sleep 1.2
            auramenu
            ;;
        *) printf "$red";exit
        ;;
    esac
}

bt_scan()
{
    banner
    printf "\e[0m\n"
    read -e -i $device -p "INTERFACE: " device
    device="${input:-$device}"
    printf "$quest "
    read -p "SAVE LOGS? (Y/N): " logsq
    case $logsq in
        [yY][eE][sS]|[yY])
            printf "$quest "
            read -p "START SCAN? (Y/N): " yesorno
            case $yesorno in
                [yY][eE][sS]|[yY])
                read -p "OUTPUT: " log
                printf "\n\e[93mSTARTING SCAN...\n"
                hciconfig $device up
                while [ 1 ]; do hcitool scan >> $log;printf "$info DONE!$info RETRYING... HIT CTRL+C TO KILL\e[0m\n";done
                printf "$info "
                read -p "PRESS [ENTER] TO BACK" variable
                auramenu
                ;;
                [nN][oO]|[nN])
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                *)
                printf "$red"
                exit
                ;;
            esac
        ;;
        [nN][oO]|[nN])
           printf "$quest "
           read -p "START SCAN? (Y/N): " yesorno
           case $yesorno in
                [yY][eE][sS]|[yY])
                printf "\n\e[93mSTARTING SCAN...\e[0m\n"
                hciconfig $device up
                while [ 1 ]; do hcitool scan;printf "\n\e[93mRETRYING... HIT CTRL+C TO KILL\e[0m\n";done
                printf "$inf "
                read -p "PRESS [ENTER] TO BACK" variable
                auramenu
                ;;
                [nN][oO]|[nN])
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                *)
                printf "$red"
                exit
                ;;
            esac
        ;;
        *)
        printf "$red"
        exit
        ;;
    esac
}

scan_site(){
    banner
    printf "\e[0m\n"
    read -p "WEBSITE ADDRES: " website
    printf "$quest "
    read -p "START SCAN? (Y/N): " yesorno
           case $yesorno in
                [yY][eE][sS]|[yY])
                printf "\n\e[93mSTARTING SCAN...\e[0m\n"
                nmap -v scanme.nmap.org
                read -p "PRESS [ENTER] TO BACK" variable
                auramenu
                ;;
                [nN][oO]|[nN])
                printf "$inf BACKING TO MENU..."
                sleep 1.2
                auramenu
                ;;
                *)
                printf "$red"
                exit
                ;;
            esac
}

edit_set(){
    banner
    printf "\nEDIT CONFIG\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) DEFAULT WIFI INTERFACE 
(2) DEFAULT BT INTERFACE
(3) ANIMATION ON START\n"
printf "\e[0m--------------------------" 
printf "
(4) BACK

"
read -p "SELECT: " sel
case $sel in
1) default_iface ;;
2) default_hci;;
3) display_animation;;
4) auramenu;;
*) printf "$red";exit ;;
esac
}

default_iface(){
    printf "\nDEFAULT INTERFACE = $iface\n"
    read -p "NEW VALUE: " input
    empty_input
    sed -i "s/iface\=.*/iface=$input/" $config_file
    source $config_file
    cout=0
    edit_set
}

default_hci(){
    printf "\nDEFAULT INTERFACE = $device\n"
    read -p "NEW VALUE: " input
    empty_input
    sed -i "s/device\=.*/device=$input/" $config_file
    source $config_file
    cout=0
    edit_set
}

display_animation(){
    printf "$quest "
    read -p "DISPLAY ANIMATION? (Y/N): " yesorno
           case $yesorno in
                [yY][eE][sS]|[yY])
                sed -i "s/cout\=.*/cout=1/" $config_file
                source $config_file
                cout=0
                edit_set
                ;;
                [nN][oO]|[nN])
                sed -i "s/cout\=.*/cout=0/" $config_file
                source $config_file
                edit_set
                ;;
                *)
                printf "$red"
                exit
                ;;
            esac
}

empty_input(){
    if [ -z "$input" ];
    then
        printf "$inf ";
        printf "INPUT CANNOT BE EMPTY...";
        sleep 2;
        edit_set;
    fi
}

net_scan(){
    
    banner
    printf "\nSCAN NETWORK\n"
    printf "\e[0m--------------------------" 
    printf "\e[0m
(1) SCAN FOR OPEN PORTS
(2) SCAN FOR OS INFO\n"
printf "\e[0m--------------------------" 
printf "
(3) BACK

"
read -p "SELECT: " sel
case $sel in
1) f_nmap ;;
2) f_nmapos ;;
3) auramenu ;;
*) printf "$red";exit ;;
esac
}

f_nmap(){
    banner
    printf "$quest "
    read -p "SAVE LOGS TO FILE? (Y/N): " save
    case $save in
        [yY][eE][sS]|[yY])
            printf "\n"
            read -p "NAME FOR LOGS: " name
            read -p "IP ADDRES TO SCAN: " IP
            nmap -oN $name $IP
            printf "\e[93m"
            read -p "PRESS [ENTER] TO BACK..." variable
            menu
            ;;
        [nN][oO]|[nN])
            printf "\n"
            read -p "IP ADDRES TO SCAN: " IP
            nmap $IP
            printf "\e[93m"
            read -p "PRESS [ENTER] TO BACK..." variable
            menu
            ;;
        *)
        printf "$red"
        ;;
    esac
}

f_nmapos(){
    banner
    printf "$quest "
    read -p "SAVE LOGS TO FILE? (Y/N): " logs
    case $logs in
        [yY][eE][sS]|[yY])
            printf "\n"
            read -p "NAME FOR LOGS: " name
            read -p "IP ADDRES TO SCAN: " IP
            nmap -oN $name -O --osscan-guess --fuzzy $IP
            printf "\e[93m"
            read -p "PRESS [ENTER] TO BACK..." variable
            menu
            ;;
        [nN][oO]|[oO])
            printf "\n"
            read -p "IP ADDRES TO SCAN: " IP
            nmap -O --osscan-guess --fuzzy $IP
            printf "\e[93m"
            read -p "PRESS [ENTER] TO BACK..."
            menu
            ;;
        *)
        printf "$red"
        ;;
    esac
}

rootcheck
f_toolscheck
auramenu 
