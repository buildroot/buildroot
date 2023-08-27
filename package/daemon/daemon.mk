################################################################################
#
# daemon
#
################################################################################

DAEMON_VERSION = 0.8.4
DAEMON_SITE = http://libslack.org/daemon/download
DAEMON_LICENSE = GPL-2.0+, LGPL-2.0+, BSD-3-Clause, Tatu Ylonen permissive license
DAEMON_LICENSE_FILES = LICENSE COPYING \
	LICENSES/LicenseRef-BSD-3-Clause-Almost.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/LGPL-2.0-or-later.txt \
	LICENSES/LicenseRef-Tatu-Ylonen-Permissive.txt

define DAEMON_CONFIGURE_CMDS
	(cd $(@D); ./configure)
endef

define DAEMON_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define DAEMON_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) DEB_BUILD_OPTIONS=nostrip \
		$(MAKE) PREFIX=$(TARGET_DIR)/usr -C $(@D) \
		install-daemon-bin
endef

$(eval $(generic-package))
