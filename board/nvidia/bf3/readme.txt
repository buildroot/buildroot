*****************
BlueField 3 Board
*****************

The BlueField 3 board is provided "as-is" without official support
from NVIDIA.

For a detailed description of this board, please refer to the official
website:
https://www.nvidia.com/en-us/networking/products/data-processing-unit/


Missing Kernel Modules
======================

Please note that the following kernel modules are unavailable as they
are not included in the Linux upstream repository:
  - CONFIG_MLXBF_PTM (module: mlxbf-ptm)
  - CONFIG_MLXBF_PKA (module: mlxbf-pka)

For further details on these kernel modules and their usage, please
refer to the NVIDIA documentation:
https://docs.nvidia.com/networking/display/bluefielddpuosv470/installing+popular+linux+distributions+on+bluefield


Boot loader
===========

NVIDIA does not provide information for rebuilding the ARM BL1, BL2,
BL3, UEFI, or other components in the boot stages. Therefore, we
assume the BF3 board is already running the pre-built Ubuntu image
provided in the BFB installation format.

Since there are no available details on the BF3's BFB format or the
ARM Trusted Firmware (ATF) needed to rebuild BL1, BL2, BL3, UEFI, or
GRUB, these components are assumed to remain unmodified.


Grub Configuration and Image Loading
====================================

The board's image is loaded from the BF3's GRUB, with the following
GRUB settings, assuming the console is set to `hvc0` to provide access
thru `/dev/rshimN/console` from the root CPU since the root CPU's
rshim exposes a virtio console over the PCIe bus to the BR3 board.

To update GRUB settings, boot using the built-in BF3 Ubuntu image.

Extract of /etc/default/grub:

    GRUB_DEFAULT=0
    GRUB_TIMEOUT_STYLE=menu
    GRUB_TIMEOUT=-1
    GRUB_RECORDFAIL_TIMEOUT=5
    GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
    GRUB_CMDLINE_LINUX_DEFAULT=""
    GRUB_CMDLINE_LINUX="console=hvc0 earlyprintk=hvc0 earlycon=hvc0 loglevel=7 fixrtc net.ifnames=0 biosdevname=0 iommu.passthrough=1"


Uploading Buildroot Images
--------------------------

After configuring GRUB, you can upload your Buildroot images to the
BF3’s GRUB boot folder:

    scp build_folder/images/Image BF3:/boot/vmlinuz-buildroot-xyz

Finally, run `update-grub` on the BF3 board to apply the updated GRUB settings.

Enjoy!
