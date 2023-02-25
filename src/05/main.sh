#!/bin/bash
. ./info_catalog.sh
. ./validator.sh

if [[ $# == 1 ]]; then
    checkLastSym $1
    if [[ $? -eq 0 ]]; then
        isDirectoryExsist $1
        if [[ $? -eq 0 ]]; then
            echo "$(get_info $1)"
        else
            echo "This directory does not exist"
        fi
    else
        echo "The format of the parameter is wrong"
    fi
else
    echo "Must be one parameter"
fi
