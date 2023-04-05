################################################################################
#
# daemon
#
################################################################################

DAEMON_VERSION = 0.8.2
DAEMON_SITE = http://libslack.org/daemon/download
DAEMON_LICENSE = GPL-2.0+, LGPL-2.0+, BSD-3-Clause
DAEMON_LICENSE_FILES = LICENSE COPYING LICENSES/BSD-3-Clause.txt LICENSES/GPL-2.0-or-later.txt

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
