#!/bin/bash

if [ $# -eq 1 ]; then
    . ./filter.sh
    RES=$?
    if [[ $RES == 1 ]]; then
        echo "Invalid input: parameter is be string"
    else
        echo $1
    fi
else
    echo "Must be only one parameter"
fi
