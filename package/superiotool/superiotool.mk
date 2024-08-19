################################################################################
#
# superiotool
#
################################################################################

SUPERIOTOOL_VERSION = 24.05
SUPERIOTOOL_SOURCE = coreboot-$(SUPERIOTOOL_VERSION).tar.xz
SUPERIOTOOL_SITE = https://coreboot.org/releases
SUPERIOTOOL_SUBDIR = util/superiotool
SUPERIOTOOL_LICENSE = GPL-2.0+
SUPERIOTOOL_LICENSE_FILES = util/superiotool/COPYING
SUPERIOTOOL_DEPENDENCIES = pciutils

SUPERIOTOOL_CFLAGS = \
	$(TARGET_CFLAGS) \
	-I$(@D)/src/commonlib/bsd/include \
	-DPCI_SUPPORT \
	-DSUPERIOTOOL_VERSION=\\\"$(SUPERIOTOOL_VERSION)\\\"

SUPERIOTOOL_CONFIGURE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	CFLAGS="$(SUPERIOTOOL_CFLAGS)"

define SUPERIOTOOL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(SUPERIOTOOL_CONFIGURE_OPTS) \
		-C $(@D)/$(SUPERIOTOOL_SUBDIR) superiotool
endef

define SUPERIOTOOL_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(SUPERIOTOOL_CONFIGURE_OPTS) \
		-C $(@D)/$(SUPERIOTOOL_SUBDIR) install \
		PREFIX=/usr DESTDIR="$(TARGET_DIR)"
endef

$(eval $(generic-package))
