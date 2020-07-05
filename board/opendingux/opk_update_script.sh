#!/bin/sh

cd `dirname $0`

DATE_FILE=./date.txt

DISCLAIMER="\Zb\Z3NOTICE\Zn

While we carefully constructed this
updater, it is possible flaws in
the updater or in the updated OS
could lead to \Zb\Z3data loss\Zn.
We recommend that you \Zb\Z3backup\Zn
all valuable personal data before
you perform the update.

Do you want to update now?"

UP_TO_DATE=yes

if [ -f "$DATE_FILE" ] ; then
	DATE="`cat $DATE_FILE`"
	export DIALOGOPTS="--colors --no-shadow --backtitle \"OpenDingux update $DATE\""
fi

echo "screen_color = (RED,RED,ON)" > /tmp/dialog_err.rc

dialog --defaultno --yes-label 'Update' --no-label 'Cancel' --yesno "$DISCLAIMER" 0 0
if [ $? -ne 0 ] ; then
	exit $?
fi

clear
echo 'Update in progress - please be patient.'
echo

if [ "$(whoami)" = "root" -a ! -x /usr/sbin/od-update ]; then
	./od-update $1
else
	sudo od-update $1
fi

ERR=$?
if [ $ERR -ne 0 ] ; then
	case $ERR in
		2)
			ERR_MSG="Failed to update rootfs!\nDo you have enough space available?"
			;;
		3)
			ERR_MSG="Failed to update mininit!"
			;;
		4)
			ERR_MSG="Failed to update kernel!"
			;;
		5)
			ERR_MSG="Failed to update modules!"
			;;
		6)
			ERR_MSG="Failed to update bootloader!"
			;;
		7)
			ERR_MSG="Updated rootfs is corrupted!\nPlease report this bug!"
			;;
		8)
			ERR_MSG="Updated mininit is corrupted!\nPlease report this bug!"
			;;
		9)
			ERR_MSG="Updated kernel is corrupted!\nPlease report this bug!"
			;;
		10)
			ERR_MSG="Updated devicetree is corrupted!\nPlease report this bug!"
			;;
		11)
			ERR_MSG="Updated bootloader is corrupted!\nPlease report this bug!"
			;;
	esac

	export DIALOGRC="/tmp/dialog_err.rc"
	dialog --msgbox "ERROR!\n\n${ERR_MSG}" 0 0
	exit $ERR
fi

case $1 in
	rs90)
		LAST_KERNEL=START
		LAST_ROOTFS=R
		;;
	gcw0)
		LAST_KERNEL=X
		LAST_ROOTFS=Y
		;;
esac

dialog --msgbox 'Update complete!\nThe system will now restart.\n\n
If for some reason the system fails to boot, try to press the
following keys while powering on the device:\n
- '"$LAST_KERNEL"' to boot the backup kernel,\n
- '"$LAST_ROOTFS"' to boot the backup rootfs.\n
Pressing both keys during the power-on sequence will load the very
same Operating System (kernel + rootfs) you had before upgrading.' 0 0
reboot
