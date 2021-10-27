################################################################################
#
# sloci-image
#
################################################################################

SLOCI_IMAGE_VERSION = 0.1.2
SLOCI_IMAGE_SITE = $(call github,jirutka,sloci-image,v$(SLOCI_IMAGE_VERSION))

SLOCI_IMAGE_LICENSE = MIT
SLOCI_IMAGE_LICENSE_FILES = LICENSE

HOST_SLOCI_IMAGE_DEPENDENCIES = host-gawk

define HOST_SLOCI_IMAGE_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) PREFIX=$(HOST_DIR) -C $(@D) install
endef

$(eval $(host-generic-package))
