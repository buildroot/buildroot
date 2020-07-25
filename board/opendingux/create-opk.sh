#!/bin/sh

DATE=`date +%F`
CONFIG=$2

mkdir -p ${BUILD_DIR}/opk/${CONFIG}/

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

# Add symlinks for compatibility with old versions of od-update script
case "${CONFIG}" in
	rs90)
		ln -sf rs90.dtb ${BUILD_DIR}/opk/${CONFIG}/v21.dtb
		ln -sf rs90.dtb ${BUILD_DIR}/opk/${CONFIG}/v30.dtb
		;;
	gcw0)
		ln -sf gcw0_proto.dtb ${BUILD_DIR}/opk/${CONFIG}/v11_ddr2_256mb.dtb
		ln -sf gcw0.dtb ${BUILD_DIR}/opk/${CONFIG}/v20_mddr_512mb.dtb
		;;
esac

for each in \
	${BINARIES_DIR}/uzImage.bin \
	${BINARIES_DIR}/modules.squashfs \
	${BINARIES_DIR}/rootfs.squashfs \
	${BINARIES_DIR}/mininit-syspart \
	${BINARIES_DIR}/ubiboot-*.bin \
	${BINARIES_DIR}/*.dtb
do
	if [ -r $each ] ; then
		each_name=`basename $each`
		cp -lf $each ${BUILD_DIR}/opk/${CONFIG}/${each_name}
		each_sha1=${BUILD_DIR}/opk/${CONFIG}/${each_name}.sha1
		sha1sum $each | cut -d' ' -f1 > $each_sha1
	fi
done

# Create OPK
${HOST_DIR}/usr/bin/mksquashfs \
	${BUILD_DIR}/opk/${CONFIG} \
	${BUILD_DIR}/opk/date.txt \
	${BUILD_DIR}/opk/default.${CONFIG}.desktop \
	board/opendingux/opendingux_icon.png \
	board/opendingux/opk_update_script.sh \
	${TARGET_DIR}/usr/sbin/od-update \
	${BINARIES_DIR}/${CONFIG}-update-${DATE}.opk \
	-noappend -no-xattrs -all-root

echo ""
echo "---"
echo "OpenDingux/${CONFIG} build completed!"
echo "The built files can be found in ${BINARIES_DIR}."
echo "A ready-to-use update OPK can be found here: ${BINARIES_DIR}/${CONFIG}-update-${DATE}.opk"
echo "---"
