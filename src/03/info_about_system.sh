#!/bin/bash

HOSTNAME=$(cat /proc/sys/kernel/hostname)
TIMEZONE="$(cat /etc/timezone) $(date +"UTC %-:::z")"
USER=$USER
OS=$(cat /etc/issue.net)
DATE=$(date +"%d %B %Y %T")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print int ($1)}' /proc/uptime)
IP=$(hostname -I | awk '{print $1}')
MASK="$(netstat -r | tail -n 1 | awk '{print $3}')"
GATEWAY=$(ip route show | grep "default via" | awk '{print $3}')
RAM_TOTAL=$(free -m | awk '/^Mem:/{print $2/1024" GB"}')
RAM_USED=$(free -m | awk '/^Mem:/{print $3/1024" GB"}')
RAM_FREE=$(free -m | awk '/^Mem:/{print $4/1024" GB"}')
SPACE_ROOT=$(df -h / | awk '/^\/dev/{print $2}')
SPACE_ROOT_USED=$(df -h / | awk '/^\/dev/{print $3}')
SPACE_ROOT_FREE=$(df -h / | awk '/^\/dev/{print $4}')

function getInfo {
    COLOR_BACK1=$(getBgrClr $1)
    COLOR_FONT1=$(getFontClr $2)
    COLOR_BACK2=$(getBgrClr $3)
    COLOR_FONT2=$(getFontClr $4)
    COLOR_DEFAULT="\033[0m"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}HOSTNAME = ${COLOR_BACK2}${COLOR_FONT2}$HOSTNAME${NORMAL}${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}TIMEZONE = ${COLOR_BACK2}${COLOR_FONT2}$TIMEZONE${NORMAL}${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}USER = ${COLOR_BACK2}${COLOR_FONT2}$USER${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}OS = ${COLOR_BACK2}${COLOR_FONT2}$OS${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}DATE = ${COLOR_BACK2}${COLOR_FONT2}$DATE${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}UPTIME = ${COLOR_BACK2}${COLOR_FONT2}$UPTIME${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}UPTIME_SEC = ${COLOR_BACK2}${COLOR_FONT2}$UPTIME_SEC${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}IP = ${COLOR_BACK2}${COLOR_FONT2}$IP${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}MASK = ${COLOR_BACK2}${COLOR_FONT2}$MASK${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}GATEWAY = ${COLOR_BACK2}${COLOR_FONT2}$GATEWAY${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}RAM_TOTAL = ${COLOR_BACK2}${COLOR_FONT2}$RAM_TOTAL${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}RAM_USED = ${COLOR_BACK2}${COLOR_FONT2}$RAM_USED${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}RAM_FREE = ${COLOR_BACK2}${COLOR_FONT2}$RAM_FREE${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}SPACE_ROOT = ${COLOR_BACK2}${COLOR_FONT2}$SPACE_ROOT${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}SPACE_ROOT_USED = ${COLOR_BACK2}${COLOR_FONT2}$SPACE_ROOT_USED${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}SPACE_ROOT_FREE = ${COLOR_BACK2}${COLOR_FONT2}$SPACE_ROOT_FREE${COLOR_DEFAULT}"
}

function getBgrClr {
    if [[ $1 == 1 ]]; then
        echo "\033[47m"
        elif [[ $1 == 2 ]]; then
        echo "\033[41m"
        elif [[ $1 == 3 ]]; then
        echo "\033[42m"
        elif [[ $1 == 4 ]]; then
        echo "\033[44m"
        elif [[ $1 == 5 ]]; then
        echo "\033[45m"
        elif [[ $1 == 6 ]]; then
        echo "\033[40m"
    fi
}

function getFontClr {
    if [[ $1 == 1 ]]; then
        echo "\033[37m"
        elif [[ $1 == 2 ]]; then
        echo "\033[31m"
        elif [[ $1 == 3 ]]; then
        echo "\033[32m"
        elif [[ $1 == 4 ]]; then
        echo "\033[34m"
        elif [[ $1 == 5 ]]; then
        echo "\033[35m"
        elif [[ $1 == 6 ]]; then
        echo "\033[30m"
    fi
}

function askUserYorN {
    if [[ $1 == "y" || $1 == "Y" ]]; then
        return 0
    else
        return 1
    fi
}
