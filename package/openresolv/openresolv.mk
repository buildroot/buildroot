################################################################################
#
# openresolv
#
################################################################################

OPENRESOLV_VERSION = 3.13.2
OPENRESOLV_SITE = https://github.com/rsmarples/openresolv/releases/download/v$(OPENRESOLV_VERSION)
OPENRESOLV_SOURCE = openresolv-$(OPENRESOLV_VERSION).tar.xz
OPENRESOLV_LICENSE = BSD-2-Clause
OPENRESOLV_LICENSE_FILES = LICENSE
OPENRESOLV_CPE_ID_VALID = YES

define OPENRESOLV_CONFIGURE_CMDS
	cd $(@D) && $(TARGET_CONFIGURE_OPTS) ./configure --sysconfdir=/etc
endef

define OPENRESOLV_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define OPENRESOLV_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))
