#!/bin/sh
COUNTER=0
TRIES=0
MAXTRIES=20
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
		((TRIES+=1))
		if [ $COUNTER -eq ${#SERVERS[@]} ]; then
			COUNTER=0
		fi

		if [ $TRIES -ge $MAXTRIES ]; then
			echo "set time failed after $TRIES times"
			exit
		else	
			updateTime
		fi
	fi	
}	

updateTime
