#!/bin/sh

TARGET_DIR=$1

# Remove executables we don't use
for i in chattr compile_et lsattr mk_cmds system_info usb-chooser ; do
	rm -f ${TARGET_DIR}/usr/bin/$i
done
for i in badblocks dumpe2fs e2freefrag e2fsck e2scrub e2scrub_all e2undo e4crypt f2fscrypt f2fs_io f2fstat fibmap.f2fs filefrag fsck.f2fs logsave mklost+found mtdinfo parse.f2fs sg_write_buffer tune2fs ubinfo ; do
	rm -f ${TARGET_DIR}/usr/sbin/$i
done
