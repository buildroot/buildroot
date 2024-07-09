################################################################################
#
# fail2ban
#
################################################################################

FAIL2BAN_VERSION = 1.1.0
FAIL2BAN_SITE = $(call github,fail2ban,fail2ban,$(FAIL2BAN_VERSION))
FAIL2BAN_LICENSE = GPL-2.0+
FAIL2BAN_LICENSE_FILES = COPYING
FAIL2BAN_CPE_ID_VENDOR = fail2ban
FAIL2BAN_SELINUX_MODULES = fail2ban
FAIL2BAN_SETUP_TYPE = setuptools

# fail2ban contains bundled copies of pyasyncore and pyasynchat,
# remove them so only the packaged versions are installed.
define FAIL2BAN_REMOVE_BUNDLED_COMPAT
	$(SED) '/fail2ban\.compat/d' $(@D)/setup.py
	rm -rf $(@D)/fail2ban/compat
endef
FAIL2BAN_POST_PATCH_HOOKS += FAIL2BAN_REMOVE_BUNDLED_COMPAT

define FAIL2BAN_FIX_DEFAULT_CONFIG
	$(SED) '/^socket/c\socket = /run/fail2ban.sock' $(TARGET_DIR)/etc/fail2ban/fail2ban.conf
	$(SED) '/^pidfile/c\pidfile = /run/fail2ban.pid' $(TARGET_DIR)/etc/fail2ban/fail2ban.conf
	$(SED) '/^dbfile/c\dbfile = None' $(TARGET_DIR)/etc/fail2ban/fail2ban.conf
endef
FAIL2BAN_POST_INSTALL_TARGET_HOOKS += FAIL2BAN_FIX_DEFAULT_CONFIG

# fail2ban-python points to host python
define FAIL2BAN_FIX_FAIL2BAN_PYTHON_SYMLINK
	ln -snf python3	$(TARGET_DIR)/usr/bin/fail2ban-python
endef
FAIL2BAN_POST_INSTALL_TARGET_HOOKS += FAIL2BAN_FIX_FAIL2BAN_PYTHON_SYMLINK

define FAIL2BAN_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/fail2ban/S60fail2ban \
		$(TARGET_DIR)/etc/init.d/S60fail2ban
endef

define FAIL2BAN_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/files/fail2ban.service.in \
		$(TARGET_DIR)/usr/lib/systemd/system/fail2ban.service
	$(SED) 's,@BINDIR@,/usr/bin,g' $(TARGET_DIR)/usr/lib/systemd/system/fail2ban.service
	$(SED) '/^PIDFile/c\PIDFile=/run/fail2ban.pid' $(TARGET_DIR)/usr/lib/systemd/system/fail2ban.service
endef

$(eval $(python-package))
