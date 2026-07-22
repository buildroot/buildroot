################################################################################
#
# agec
#
################################################################################

AGEC_VERSION = 0.1.0
AGEC_SOURCE = $(AGEC_VERSION).tar.gz
AGEC_SITE = https://git.sr.ht/~min/agec/archive
AGEC_LICENSE = 0BSD
AGEC_LICENSE_FILES = LICENSE
AGEC_DEPENDENCIES = host-pkgconf openssl

define AGEC_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs openssl`"
endef

define AGEC_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		PREFIX=$(TARGET_DIR)/usr install
endef

$(eval $(generic-package))
