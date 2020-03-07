#!/bin/bash

HRI_P="
hri1
hri2
"

NAVI_P="
navi1
navi2
"

AP=$(cat log.txt | grep -Pzo "(?s)(?<=Active Process).*?(?=Not Active Process)" | awk 'NF')
NAP=$(cat log.txt | awk 'f; /Not Active Process/ {f=1}')


echo -e "\nChecking"

for check_hri in ${HRI_P}
do
    for process in $AP
    do
        if [ "$process" == "$check_hri" ]; then
            echo $process
        fi
    done
done

for check_navi in ${NAVI_P}
do
    for process in $AP
    do
        if [ "$process" == "$check_navi" ]; then
            echo $process
        fi
    done
done


