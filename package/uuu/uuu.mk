################################################################################
#
# uuu
#
################################################################################

UUU_VERSION = 1.4.193
UUU_SITE = $(call github,NXPmicro,mfgtools,uuu_$(UUU_VERSION))
UUU_LICENSE = BSD 3-Clause "New" or "Revised" License
UUU_LICENSE_FILES = LICENSE README.md
HOST_UUU_DEPENDENCIES = host-bzip2 host-zlib host-libusb

define UUU_SET_VERSION
	echo $(UUU_VERSION) > $(@D)/.tarball-version
endef

HOST_UUU_POST_EXTRACT_HOOKS += UUU_SET_VERSION

$(eval $(host-cmake-package))
