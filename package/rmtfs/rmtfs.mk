################################################################################
#
# rmtfs
#
################################################################################

RMTFS_VERSION = 1.3
RMTFS_SITE = $(call github,linux-msm,rmtfs,v$(RMTFS_VERSION))
RMTFS_LICENSE = BSD-3-Clause
RMTFS_LICENSE_FILES = LICENSE
RMTFS_DEPENDENCIES = qrtr udev

# qmi_rmtfs.c/.h are shipped pre-generated: keep make from regenerating
# them with qmic, which is not packaged, when the tarball timestamps make
# qmi_rmtfs.qmi look newer.
define RMTFS_TOUCH_GENERATED
	touch $(@D)/qmi_rmtfs.c $(@D)/qmi_rmtfs.h
endef
RMTFS_PRE_BUILD_HOOKS += RMTFS_TOUCH_GENERATED

# The Makefile appends the libraries to LDFLAGS, which a command-line
# LDFLAGS would override.
define RMTFS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		LDFLAGS="$(TARGET_LDFLAGS) -lqrtr -ludev -lpthread" \
		-C $(@D) rmtfs rmtfs.service prefix=/usr
endef

define RMTFS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rmtfs $(TARGET_DIR)/usr/bin/rmtfs
endef

define RMTFS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(RMTFS_PKGDIR)/S45rmtfs \
		$(TARGET_DIR)/etc/init.d/S45rmtfs
endef

define RMTFS_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/rmtfs.service \
		$(TARGET_DIR)/usr/lib/systemd/system/rmtfs.service
	$(INSTALL) -D -m 0644 $(@D)/rmtfs.rules \
		$(TARGET_DIR)/usr/lib/udev/rules.d/rmtfs.rules
endef

$(eval $(generic-package))
