#!/bin/bash

firmware=$(echo $1 | sed 's/\\/\//g')

if [ x"$2" != x"" ]; then
    port=$2
else
    port=$FLASH_PORT
fi

COLOR_SUC="\e[32;1m"
COLOR_ERR="\e[31;1m"
COLOR_END="\e[0m"

if [ x"$port" == x"" ]; then
    
    pList=(`./tools/W800/wm_tool.exe -l`)

    if [ ${#pList[@]} == 0 ]; then
        echo -e ""
        echo -e ${COLOR_ERR}"!!! Error, not found any serialport !, check your connection !!!"${COLOR_END}
        echo -e ""
        exit -1
    fi

    for p in ${pList[@]}; do
        if [ x"$p" != x"COM1" ]; then
            port=$p
            break
        fi
    done

    if [ x"$port" == x"" ]; then
        port=${pList[0]}
    fi
fi

echo --------------------------------------------
echo file: $firmware
echo port: $port
echo --------------------------------------------
echo ''

./tools/W800/wm_tool.exe -dl "$firmware" -ws 2M -ds 2M -rs rts -c $port
