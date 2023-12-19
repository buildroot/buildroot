#!/bin/sh -eu

#
# atf_image extracts the ATF binary image from DTB_FILE_NAME that appears in
# BR2_TARGET_ARM_TRUSTED_FIRMWARE_ADDITIONAL_VARIABLES in ${BR_CONFIG},
# then prints the corresponding file name for the genimage
# configuration file
#
atf_image()
{
	ATF_VARIABLES="$(sed -n 's/^BR2_TARGET_ARM_TRUSTED_FIRMWARE_ADDITIONAL_VARIABLES="\([^\"]*\)"$/\1/p' ${BR2_CONFIG})"
	# make sure DTB_FILE_NAME is set
	printf '%s\n' "${ATF_VARIABLES}" | grep -Eq 'DTB_FILE_NAME=[0-9A-Za-z_\-]*'
	# extract the value
	DTB_FILE_NAME="$(printf '%s\n' "${ATF_VARIABLES}" | sed 's/.*DTB_FILE_NAME=\([a-zA-Z0-9_\-]*\)\.dtb.*/\1/')"
	echo "tf-a-${DTB_FILE_NAME}.stm32"
}

main()
{
	ATFBIN="$(atf_image)"
	GENIMAGE_CFG="$(mktemp --suffix genimage.cfg)"

	sed -e "s/%ATFBIN%/${ATFBIN}/" \
		board/stmicroelectronics/common/stm32mp157/genimage.cfg.template > ${GENIMAGE_CFG}

	support/scripts/genimage.sh -c ${GENIMAGE_CFG}

	rm -f ${GENIMAGE_CFG}

	exit $?
}

main $@
