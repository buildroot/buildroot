# Open Trickler Buildroot

This repo creates the Linux firmware images for the Open Trickler project.


## Configuration

The following files and directories are the most relevant for Open Trickler:

- `configs/opentrickler_dev_defconfig`
- `configs/opentrickler_prod_defconfig`
- `package/python-opentrickler/`
- `board/ammolytics/opentrickler/`


## Build commands

    make opentrickler_dev_defconfig
    make

The resulting firmware images will be in `output/images/`.


## Syncing with upstream Buildroot

Always keep commits to the `opentrickler-2022.05.x` on top of the latest upstream `2022.05.x` branch.

    git checkout 2022.05.x
    git pull
    git checkout opentrickler-2022.05.x
    git merge 2022.05.x
    git push origin opentrickler-2022.05.x


## Inspecting the image filesystem

First, use `fdisk` to list the partitions and block positions.

    fdisk -l  output/images/sdcard.img

Example output

    Disk output/images/sdcard.img: 596 MiB, 624951808 bytes, 1220609 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x00000000

    Device                    Boot   Start     End Sectors  Size Id Type
    output/images/sdcard.img1 *          1   65536   65536   32M  c W95 FAT32 (LBA)
    output/images/sdcard.img2        65537 1089536 1024000  500M 83 Linux
    output/images/sdcard.img3      1089537 1220608  131072   64M  c W95 FAT32 (LBA)


The math that determines the block offset needed to mount a parition

    start * sector size = offset  # equation
    1 * 512 = 512  # BOOT parition
    65537 * 512 = 33554944  # Linux root partition
    1089537 * 512 = 557842944  # CODE parition


Mounting the paritions (read-only)

    sudo mkdir /mnt/ot-img/boot /mnt/ot-img/rootfs /mnt/ot-img/code
    sudo mount -o loop,ro,sync,offset=512 output/images/sdcard.img /mnt/ot-img/boot
    sudo mount -o loop,ro,offset=33554944 -t ext4 output/images/sdcard.img /mnt/ot-img/rootfs
    sudo mount -o loop,ro,sync,offset=557842944 output/images/sdcard.img /mnt/ot-img/code


Unmount the paritions

    sudo umount /mnt/ot-img/boot
    sudo umount /mnt/ot-img/rootfs
    sudo umount /mnt/ot-img/code
