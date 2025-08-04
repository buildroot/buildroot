################################################################################
#
# uuu
#
################################################################################

UUU_VERSION = 1.5.219
UUU_SOURCE = uuu_source-uuu_$(UUU_VERSION).tar.gz
UUU_SITE = https://github.com/nxp-imx/mfgtools/releases/download/uuu_$(UUU_VERSION)
UUU_LICENSE = BSD 3-Clause "New" or "Revised" License
UUU_LICENSE_FILES = LICENSE
UUU_DEPENDENCIES = bzip2 libusb openssl tinyxml2 zlib zstd
HOST_UUU_DEPENDENCIES = \
	host-bzip2 \
	host-libusb \
	host-openssl \
	host-tinyxml2 \
	host-zlib \
	host-zstd

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
UUU_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))
