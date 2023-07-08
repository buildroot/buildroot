################################################################################
#
# dfu-programmer
#
################################################################################

DFU_PROGRAMMER_VERSION = 1.0.0
DFU_PROGRAMMER_SITE = https://github.com/dfu-programmer/dfu-programmer/releases/download/v$(DFU_PROGRAMMER_VERSION)
DFU_PROGRAMMER_LICENSE = GPL-2.0+
DFU_PROGRAMMER_LICENSE_FILES = COPYING
DFU_PROGRAMMER_DEPENDENCIES = libusb

# No update-bash-completion.sh in tarball. Fix sent upstream:
# https://github.com/dfu-programmer/dfu-programmer/pull/91
define DFU_PROGRAMMER_ADD_MISSING_FILE
	ln -s /bin/true $(@D)/update-bash-completion.sh
endef

DFU_PROGRAMMER_POST_PATCH_HOOKS == DFU_PROGRAMMER_ADD_MISSING_FILE

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
DFU_PROGRAMMER_CONF_OPTS += LIBS=-latomic
endif

$(eval $(autotools-package))
