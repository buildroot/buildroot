################################################################################
#
# altera-stapl
#
################################################################################

ALTERA_STAPL_VERSION = 7044a63b7d1a3fc6840cd3130ec984454f1559c0
ALTERA_STAPL_SITE = $(call github,kontron,altera-stapl,$(ALTERA_STAPL_VERSION))
ALTERA_STAPL_LICENSE = GPLv2+
ALTERA_STAPL_LICENSE_FILES = COPYING
ALTERA_STAPL_DEPENDENCIES = libgpiod

define ALTERA_STAPL_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define ALTERA_STAPL_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
