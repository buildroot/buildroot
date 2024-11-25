#!/bin/sh

candidate="$1"

zstdcat=$(which "$candidate" 2>/dev/null)
if [ ! -x "$zstdcat" ]; then
	zstdcat=$(which zstdcat 2>/dev/null)
	if [ ! -x "$zstdcat" ]; then
		# echo nothing: no suitable zstdcat found
		exit 1
	fi
fi

echo "$zstdcat"
