#!/bin/sh

# By default U-Boot loads DTB from a file named "system.dtb", and
# with versal2, the Linux DTB is the same as the U-Boot DTB, so
# let's use a symlink since the DTB is the same.
ln -fs "${BINARIES_DIR}/u-boot.dtb" "${BINARIES_DIR}/system.dtb"

BOARD_DIR="$(dirname "$0")"

cat <<-__HEADER_EOF > "${BINARIES_DIR}/bootgen.bif"
	the_ROM_image:
	{
	  image {
	    { type=bootimage, file=${BINARIES_DIR}/boot.pdi }
	    { type=bootloader, file=${BINARIES_DIR}/plm.elf }
	    { core=asu, file=${BINARIES_DIR}/asufw.elf }
	  }
	  image {
	    id = 0x1c000000, name=apu_subsystem
	    { type=raw, load=0x01000000, file=${BINARIES_DIR}/u-boot.dtb }
	    { core=a78-0, cluster=0, exception_level=el-3, trustzone, file=${BINARIES_DIR}/bl31.elf }
	    { core=a78-0, cluster=0, exception_level=el-1, trustzone, load=0x1800000, file=${BINARIES_DIR}/tee-raw.bin }
	    { core=a78-0, cluster=0, exception_level=el-2, file=${BINARIES_DIR}/u-boot.elf }
	  }
	}
	__HEADER_EOF

"${HOST_DIR}/bin/bootgen" -arch versal_2ve_2vm -image "${BINARIES_DIR}/bootgen.bif" -o "${BINARIES_DIR}/boot.bin" -w on
support/scripts/genimage.sh -c "${BOARD_DIR}/genimage.cfg"
