#!/bin/sh
# simple test which creates a dummy file system image, then use bmaptool create
# and bmaptool copy to copy it to another file

set -xeu

# create the necessary test files
dd if=/dev/zero of=disk.img bs=2M count=1
mkfs.ext4 disk.img
fallocate -d disk.img
dd if=/dev/zero of=copy.img bs=2M count=1

# do a test copy of the file system image
bmaptool create -o disk.img.bmap disk.img
bmaptool copy disk.img copy.img
cmp disk.img copy.img
