################################################################################
#
# uuu
#
################################################################################

UUU_VERSION = 1.5.201
UUU_SOURCE = uuu_source-uuu_$(UUU_VERSION).tar.gz
UUU_SITE = https://github.com/nxp-imx/mfgtools/releases/download/uuu_$(UUU_VERSION)
UUU_LICENSE = BSD 3-Clause "New" or "Revised" License
UUU_LICENSE_FILES = LICENSE
HOST_UUU_DEPENDENCIES = \
	host-bzip2 \
	host-libusb \
	host-openssl \
	host-tinyxml2 \
	host-zlib \
	host-zstd

$(eval $(host-cmake-package))
