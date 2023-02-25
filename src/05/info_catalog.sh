#!/bin/bash

function get_info {
    START=$(date +%s)
    IFS=''
    COUNT_STR=$(du -h $1 | sort -rh | head -6 | wc -l)
    echo "Total number of folders (including all nested ones) = $(($(find $1 -type d | wc -l)-1))"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    du -h $1 | sort -rh | head -6 | tail -n $(($COUNT_STR - 1)) | awk '{print NR " - " $2 ", " $1}'
    echo "Total number of files = $(ls -laR $1 | grep "^-" | wc -l)"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $(ls -laR $1 | grep ".conf" | wc -l)"
    echo "Text files = $(ls -laR $1 | grep ".txt" | wc -l)"
    echo "Executable files = $(find $1 -executable -type f | wc -l)"
    echo "Log files (with the extension .log) = $(ls -laR $1 | grep ".log" | wc -l)"
    echo "Archive files = $(find $1 -regextype posix-egrep -regex '.*(ace|arj|bin|cab|cbr|exe|gz|gzip|jar|one|pak|pkg|ppt|rar|rpm|sh|sib|sis|sisx|sit|sitx|spl|spl|tar|tar-gz|tgz|xar|zip|zipx)$' | wc -l)"
    echo "Symbolic links = $(ls -laR $1 | grep ^l | wc -l)"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    FILES="$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | awk '{print NR " - " $2$3$4$5$6 ", " $1 ", "}')"
    COUNT_OF_STRING="$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | wc -l)"
    for (( i=1; i <= $COUNT_OF_STRING; i++ ))
    do
        echo -n "$(echo $FILES | awk -v m=$i '(NR == m)')"
        echo "$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | awk -v m=$i '(NR == m)' | grep -Eo '\.[^.][a-z~]+$' | cut -c 2-20)"
    done
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    echo $(find $1 -type f -executable -exec du -h {} + | sort -hr | head -10 | awk '{printf NR " - " $2 " " $1 ", "; system("md5sum $2 | cut -f 1 -d \" \"")}')
    END=$(date +%s)
    DIFF=$(($END - $START))
    echo "Script execution time (in seconds) = $DIFF"
}
