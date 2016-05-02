#!/bin/sh
COUNTER=0
SLEEP=1
SERVERS=("time-a.nist.gov" "time-b.nist.gov" "time-c.nist.gov" "utcnist.colorado.edu" "utcnist2.colorado.edu")

function updateTime {
	echo "try to set time via ${SERVERS[$COUNTER]}"
	result=$(rdate ${SERVERS[$COUNTER]});
	if [[ "$result" =~ [0-9]{2}:[0-9]{2}:[0-9]{2} ]]; then
		exit
	else
		echo "retry to set time in $SLEEP seconds"
		sleep $SLEEP
		((COUNTER+=1))

		if [ $COUNTER -eq ${#SERVERS[@]} ]; then
			COUNTER=0
		fi

		updateTime
	fi	
}	

updateTime
