#!/bin/bash

HRI_P="
hri1
hri2
"

NAVI_P="
navi1
navi2
navi3
"
RESULT_HRI="PASS"
RESULT_NAVI="PASS"

AP=$(cat log.txt | grep -Pzo "(?s)(?<=Active Process).*?(?=Not Active Process)" | awk 'NF')
NAP=$(cat log.txt | awk 'f; /Not Active Process/ {f=1}')

for process in $NAP
do	
    for check_hri in $HRI_P
    do
        if [ "$process" == "$check_hri" ]; then
            RESULT_HRI="FAIL"
        fi
    done
 
    for check_navi in $NAVI_P
    do
        if [ "$process" == "$check_navi" ]; then
            RESULT_NAVI="FAIL"
        fi
    done
done

jq -n \
    --arg hri $RESULT_HRI\
    --arg navi $RESULT_NAVI\
    '
    [(.name="HRI" | .result=$hri),
    (.name="NAVI" | .result=$navi)]
    ' > ex.json

