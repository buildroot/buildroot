#!/bin/sh

# By default U-Boot loads DTB from a file named "system.dtb", so
# let's use a symlink with that name that points to the *first*
# devicetree listed in the config.

FIRST_DT=$(sed -nr \
               -e 's|^BR2_LINUX_KERNEL_INTREE_DTS_NAME="xilinx/([-_/[:alnum:]\\.]*).*"$|\1|p' \
               ${BR2_CONFIG})

[ -z "${FIRST_DT}" ] || ln -fs ${FIRST_DT}.dtb ${BINARIES_DIR}/system.dtb

BOARD_DIR="$(dirname $0)"
BOARD_NAME=$4

mkdir -p "${BINARIES_DIR}"
cat <<-__HEADER_EOF > "${BINARIES_DIR}/bootgen.bif"
	the_ROM_image:
	{
	  image {
	    { type=bootimage, file=${BINARIES_DIR}/${BOARD_NAME}_vpl_gen_fixed.pdi }
	    { type=bootloader, file=${BINARIES_DIR}/${BOARD_NAME}_plm.elf }
	    { core=psm, file=${BINARIES_DIR}/${BOARD_NAME}_psmfw.elf }
	  }
	  image {
	    id = 0x1c000000, name=apu_subsystem 
	    { type=raw, load=0x00001000, file=${BINARIES_DIR}/system.dtb }
	    { core=a72-0, exception_level=el-3, trustzone, file=${BINARIES_DIR}/bl31.elf }
	    { core=a72-0, exception_level=el-2, file=${BINARIES_DIR}/u-boot.elf }
	  }
	}
	__HEADER_EOF

${HOST_DIR}/bin/bootgen -arch versal -image ${BINARIES_DIR}/bootgen.bif -o ${BINARIES_DIR}/boot.bin -w on
support/scripts/genimage.sh -c ${BOARD_DIR}/genimage.cfg
