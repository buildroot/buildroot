#!/bin/sh

# Either start or stop all the services in
# /usr/local/etc/init.d, executing them in numerical order.

# Action: either "start" or "stop".
ACTION=$1


if [ "x$ACTION" = "xstop" ]; then
    SORTARG="-r"
else
    ACTION="start"
fi

LOCALINITFILES=`ls -1 /usr/local/etc/init.d/S??* 2>/dev/null | sed -e 's%\(.*\)/\([^/]*\)$%\2 \1/\2%' | sort -k 1 $SORTARG |cut -d ' ' -f 2`

for i in $LOCALINITFILES ; do

     # Ignore dangling symlinks (if any).
     [ ! -f "$i" ] && continue

     case "$i" in
	*.sh)
	    # Source shell script for speed.
	    (
		trap - INT QUIT TSTP
		set $ACTION
		. $i
	    )
	    ;;
	*)
	    # No sh extension, so fork subprocess.
	    $i $ACTION
	    ;;
    esac
done
