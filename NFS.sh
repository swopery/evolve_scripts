#!/bin/bash

for i in `find /export/home/ -maxdepth 1 -exec basename '{}' \;`
do
        if [ $i == 'tmp' ] || [ $i == 'backup' ] || [ $i == 'home' ]; then
                continue
        fi
                id $i > /dev/null 2>&1 
                if [ $? != 0 ]; then
                        echo $i "has been flagged"
                fi
done   
