#!/bin/bash

function checkLastSym {
    str=$1
    length=$((${#str}-1))
    if [[ $length > 0 ]]; then
        SYM=${str:$length:1}
        if [[ $SYM == "/" ]]; then
            return 0
        else
            return 2
        fi
    else
        return 1
    fi
}

function isDirectoryExsist {
    FILE=$1
    if [[ -d "$FILE" ]]; then
        return 0
    else
        return 1
    fi
}
