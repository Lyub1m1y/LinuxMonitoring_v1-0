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
    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = $TIMEZONE"
    echo "USER = $USER"
    echo "OS = $OS"
    echo "DATE = $DATE"
    echo "UPTIME = $UPTIME"
    echo "UPTIME_SEC = $UPTIME_SEC"
    echo "IP = $IP"
    echo "MASK = $MASK"
    echo "GATEWAY = $GATEWAY"
    echo "RAM_TOTAL = $RAM_TOTAL"
    echo "RAM_USED = $RAM_USED"
    echo "RAM_FREE = $RAM_FREE"
    echo "SPACE_ROOT = $SPACE_ROOT"
    echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
    echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
}

function askUserYorN {
    if [[ $1 == "y" || $1 == "Y" || $1 == "" ]]; then
        return 0
    else
        return 1
    fi
}
