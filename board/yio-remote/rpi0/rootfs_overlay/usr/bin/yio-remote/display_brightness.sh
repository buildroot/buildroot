#!/bin/bash

current_level=$1
level=$2

if [[ $level -ge 0 && $level -le 255 ]]; then

if [[ $level > $current_level ]]; then
counter=$current_level
while [ $counter -le $level ]
do
   # echo $counter
   gpio -g pwm 12 $counter
   ((counter++))
   sleep 0.001
done
fi

if [[ $level < $current_level ]]; then
counter=$current_level
while [ $counter -gt $level ]
do
  # echo $counter
  gpio -g pwm 12 $counter
  ((counter--))
  sleep 0.001
done
fi

exit 0
else

exit 1
fi
