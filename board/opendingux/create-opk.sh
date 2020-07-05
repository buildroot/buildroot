#!/bin/sh

mkdir -p ${BUILD_DIR}/opk

DATE=`date +%F`
CONFIG=$2

# Write metadata.
cat > ${BUILD_DIR}/opk/default.${CONFIG}.desktop <<EOF
[Desktop Entry]
Name=OS Update
Comment=OpenDingux Update $DATE
Icon=opendingux_icon
Terminal=true
Type=Application
StartupNotify=true
Categories=applications;
Exec=opk_update_script.sh ${CONFIG}
EOF

echo "$DATE" > ${BUILD_DIR}/opk/date.txt

FILE_LIST=""
FILE_LIST_SHA1=""

for each in \
	${BINARIES_DIR}/uzImage.bin \
	${BINARIES_DIR}/modules.squashfs \
	${BINARIES_DIR}/rootfs.squashfs \
	${BINARIES_DIR}/mininit-syspart \
	${BINARIES_DIR}/ubiboot-*.bin \
	${BINARIES_DIR}/*.dtb
do
	if [ -r $each ] ; then
		each_sha1=${BUILD_DIR}/opk/`basename $each`.sha1
		sha1sum $each | cut -d' ' -f1 > $each_sha1
		FILE_LIST="$FILE_LIST $each"
		FILE_LIST_SHA1="$FILE_LIST_SHA1 $each_sha1"
	fi
done

# Create OPK
${HOST_DIR}/usr/bin/mksquashfs \
	${FILE_LIST} \
	${FILE_LIST_SHA1} \
	${BINARIES_DIR}/${CONFIG}-update-${DATE}.opk \
	-noappend -no-xattrs -all-root

${HOST_DIR}/usr/bin/mksquashfs \
	board/opendingux/opendingux_icon.png \
	board/opendingux/opk_update_script.sh \
	${TARGET_DIR}/usr/sbin/od-update \
	${BUILD_DIR}/opk/date.txt \
	${BUILD_DIR}/opk/default.${CONFIG}.desktop \
	${BINARIES_DIR}/${CONFIG}-update-${DATE}.opk \
	-root-becomes ${CONFIG} -no-xattrs -all-root -no-progress

echo ""
echo "---"
echo "OpenDingux/${CONFIG} build completed!"
echo "The built files can be found in ${BINARIES_DIR}."
echo "A ready-to-use update OPK can be found here: ${BINARIES_DIR}/${CONFIG}-update-${DATE}.opk"
echo "---"
