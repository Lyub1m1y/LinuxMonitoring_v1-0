function getInfo {
    
    #get last symbol
    LAST_SYM_1=$(getLastSym $(grep column1_background ./colors.cfg))
    LAST_SYM_2=$(getLastSym $(grep column1_font_color ./colors.cfg))
    LAST_SYM_3=$(getLastSym $(grep column2_background ./colors.cfg))
    LAST_SYM_4=$(getLastSym $(grep column2_font_color ./colors.cfg))
    
    # set default value
    if ! [[ $LAST_SYM_1 =~ ^[1-6]$ ]]; then
        LAST_SYM_1=1
    fi
    if ! [[ $LAST_SYM_2 =~ ^[1-6]$ ]]; then
        LAST_SYM_2=2
    fi
    if ! [[ $LAST_SYM_3 =~ ^[1-6]$ ]]; then
        LAST_SYM_3=3
    fi
    if ! [[ $LAST_SYM_4 =~ ^[1-6]$ ]]; then
        LAST_SYM_4=4
    fi
    
    # set default value if them are the same
    if [[ $LAST_SYM_1 == $LAST_SYM_2 ]]; then
        LAST_SYM_1=1
        LAST_SYM_2=2
    fi
    
    if [[ $LAST_SYM_3 == $LAST_SYM_4 ]]; then
        LAST_SYM_3=3
        LAST_SYM_4=4
    fi
    
    # get color fonts and backgrounds
    COLOR_BACK1=$(getBackgroundColor $LAST_SYM_1)
    COLOR_FONT1=$(getFontColor $LAST_SYM_2)
    COLOR_BACK2=$(getBackgroundColor $LAST_SYM_3)
    COLOR_FONT2=$(getFontColor $LAST_SYM_4)
    COLOR_DEFAULT="\033[0m"
    
    echo -e "${COLOR_BACK1}${COLOR_FONT1}HOSTNAME = ${COLOR_BACK2}${COLOR_FONT2}$(cat /proc/sys/kernel/hostname)${NORMAL}${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}TIMEZONE = ${COLOR_BACK2}${COLOR_FONT2}$(cat /etc/timezone) $(date +"UTC %-:::z")${NORMAL}${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}USER = ${COLOR_BACK2}${COLOR_FONT2}$USER${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}OS = ${COLOR_BACK2}${COLOR_FONT2}$(cat /etc/issue.net)${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}DATE = ${COLOR_BACK2}${COLOR_FONT2}$(date +"%d %B %Y %T")${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}UPTIME = ${COLOR_BACK2}${COLOR_FONT2}$(uptime -p)${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}UPTIME_SEC = ${COLOR_BACK2}${COLOR_FONT2}$(awk '{print int ($1)}' /proc/uptime)${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}IP = ${COLOR_BACK2}${COLOR_FONT2}$(hostname -I | awk '{print $1}')${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}MASK = ${COLOR_BACK2}${COLOR_FONT2}$(netstat -r | tail -n 1 | awk '{print $3}')${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}GATEWAY = ${COLOR_BACK2}${COLOR_FONT2}$(ip route | grep default | awk '{print $3}')${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}RAM_TOTAL = ${COLOR_BACK2}${COLOR_FONT2}$(bc<<<"scale=3;($(free -m | grep Mem | awk '{print $2}') / 1024)")${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}RAM_USED = ${COLOR_BACK2}${COLOR_FONT2}$(bc<<<"scale=3;($(free -m | grep Mem | awk '{print $3}') / 1024)")${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}RAM_FREE = ${COLOR_BACK2}${COLOR_FONT2}$(bc<<<"scale=3;($(free -m | grep Mem | awk '{print $4}') / 1024)")${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}SPACE_ROOT = ${COLOR_BACK2}${COLOR_FONT2}$(bc<<<"scale=2;($(df /root | tail -n 1 | awk '{print $2}') / 1024)")${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}SPACE_ROOT_USED = ${COLOR_BACK2}${COLOR_FONT2}$(bc<<<"scale=2;($(df /root | tail -n 1 | awk '{print $3}') / 1024)")${COLOR_DEFAULT}"
    echo -e "${COLOR_BACK1}${COLOR_FONT1}SPACE_ROOT_FREE = ${COLOR_BACK2}${COLOR_FONT2}$(bc<<<"scale=2;($(df /root | tail -n 1 | awk '{print $4}') / 1024)")${COLOR_DEFAULT}"
    echo ""
    echo "Column 1 background = $(getNumberOfColumn1Background $LAST_SYM_1) ($(getNameOfColor $LAST_SYM_1))"
    echo "Column 1 font color = $(getNumberOfColumn1FontColor $LAST_SYM_2) ($(getNameOfColor $LAST_SYM_2))"
    echo "Column 2 background = $(getNumberOfColumn2Background $LAST_SYM_3) ($(getNameOfColor $LAST_SYM_3))"
    echo "Column 2 font color = $(getNumberOfColumn2FontColor $LAST_SYM_4) ($(getNameOfColor $LAST_SYM_4))"
}

function getLastSym {
    str=$1
    length=$((${#str}-1))
    if [[ $length == 19 ]]; then
        echo ${str:$length:1};
    else
        echo ""
    fi
}

function getBackgroundColor {
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

function getFontColor {
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

function getNumberOfColumn1Background {
    if [[ $1 == 1 ]]; then
        echo "default"
    else
        echo $1
    fi
}

function getNumberOfColumn1FontColor {
    if [[ $1 == 2 ]]; then
        echo "default"
    else
        echo $1
    fi
}

function getNumberOfColumn2Background {
    if [[ $1 == 3 ]]; then
        echo "default"
    else
        echo $1
    fi
}

function getNumberOfColumn2FontColor {
    if [[ $1 == 4 ]]; then
        echo "default"
    else
        echo $1
    fi
}

function getNameOfColor {
    if [[ $1 == 1 ]]; then
        echo "white"
        elif [[ $1 == 2 ]]; then
        echo "red"
        elif [[ $1 == 3 ]]; then
        echo "green"
        elif [[ $1 == 4 ]]; then
        echo "blue"
        elif [[ $1 == 5 ]]; then
        echo "purple"
        elif [[ $1 == 6 ]]; then
        echo "black"
    fi
}
