#!/bin/bash

if [[ $1 =~ ^[-]?[0-9]+$ ]]; then
    return 1
    elif [[ $1 =~ ^[-]?[0-9]+([.][0-9]+)$ ]]; then
    return 1
else
    return 0
fi
