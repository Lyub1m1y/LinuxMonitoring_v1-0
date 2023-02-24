#!/bin/bash
. ./info_about_system.sh

if [[ $# -eq 0 ]]; then
    INFO=$(getInfo)
    echo "$INFO"
    echo ""
    echo -n "Do you want to save this data? [Y/n]"
    read ANSWER
    askUserYorN $ANSWER
    if [[ $? -eq 0 ]]; then
        date=$(date +"%d_%m_%y_%H_%M_%S")
        filename="$date.status"
        echo "$INFO" > $filename
    fi
else
    echo "The script works without parameters"
fi
