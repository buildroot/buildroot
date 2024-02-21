################################################################################
#
# udpxy
#
################################################################################

UDPXY_VERSION = 1.0-25.1
UDPXY_SITE = $(call github,pcherenkov,udpxy,$(UDPXY_VERSION))
UDPXY_LICENSE = GPL-3.0+
UDPXY_LICENSE_FILES = README

define UDPXY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		ALL_CFLAGS="$(TARGET_CFLAGS)" -C $(@D)/chipmunk
endef

define UDPXY_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/chipmunk DESTDIR=$(TARGET_DIR) \
		PREFIX=/usr -C $(@D)/chipmunk install
endef

$(eval $(generic-package))
