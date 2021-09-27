#!/bin/sh

candidate="$1"

lzip=`command -v $candidate 2>/dev/null`
if [ ! -x "$lzip" ]; then
	lzip=`command -v lzip 2>/dev/null`
	if [ ! -x "$lzip" ]; then
		# echo nothing: no suitable lzip found
		exit 1
	fi
fi

echo $lzip
