#!/bin/bash

. ./info_about_system.sh
. ./validator.sh

if [[ $# -eq 4 ]]; then
    isValidArguments $1 $2 $3 $4
    if [[ $? -eq 0 ]]; then
        isValidColors $1 $2 $3 $4
        if [[ $? -eq 0 ]]; then
            echo "$(getInfo $1 $2 $3 $4)"
        else
            echo -n "The colors of the font and the background of one column should not match. Shall I try again? [Y/n]"
            read ANSWER
            askUserYorN $ANSWER
            if [[ $? -eq 0 ]]; then
                echo "Input 4 parameters"
                read one two tree four
                . ./main.sh $one $two $tree $four
            fi
        fi
    else
        echo "Parameters must be a number from 1 to 6 inclusive"
    fi
else
    echo "You need to enter 4 parameters"
fi
