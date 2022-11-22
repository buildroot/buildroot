#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

IFS= read -r -d $'\0' MODEL </sys/firmware/devicetree/base/compatible

case "$MODEL" in
	gcw,zero)
		NAME=gcw0
		;;
	*)
		NAME=$(echo $MODEL |cut -d',' -f2)
		;;
esac

psplash_write "Setting hostname to $NAME..."

/bin/hostname "$NAME"
