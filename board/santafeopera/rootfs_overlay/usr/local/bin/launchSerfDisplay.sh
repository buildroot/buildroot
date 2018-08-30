#!/bin/bash

FIRST_RUN=/root/displayUnit.firstRun
PATH=$PATH:/usr/local/bin

source /root/.qt5-env.sh

if [ -e $FIRST_RUN ]
then
    /usr/local/bin/sfo-backlight 100 >/dev/null
    setIp
    grep "setIp" /etc/network/interfaces >/dev/null
    if [ $? == 0 ]
    then
        # no need to run this next time
        rm $FIRST_RUN
    fi
fi

# for production remove the -d (diagnostic screen)
SerfDisplay -fd &
