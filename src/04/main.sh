#!/bin/bash
. ./info_about_system.sh

if [[ $# == 0 ]]; then
    echo "$(getInfo)"
else
    echo "The script works without parameters"
fi
