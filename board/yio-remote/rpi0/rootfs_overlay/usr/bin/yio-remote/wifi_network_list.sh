#!/bin/bash
i=0

wpa_cli scan | grep 'OK' &> /dev/null

if [ $? == 0 ]; then
    # echo 'OK'
    wpa_cli scan_results | 
    while IFS= read -r line
    do
        if [ "$i" -gt "1" ]; then
            echo $line | awk '{ print $3, $5 }' | tr ' ' ,
            # echo $line | awk '{ print $5; }'
        fi
        i=$((i+1))
    done
else 
    echo 'Scan failed'
fi