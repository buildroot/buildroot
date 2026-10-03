################################################################################
#
# supervisor
#
################################################################################

SUPERVISOR_VERSION = 4.3.0
SUPERVISOR_SITE = https://files.pythonhosted.org/packages/a9/b5/37e7a3706de436a8a2d75334711dad1afb4ddffab09f25e31d89e467542f
SUPERVISOR_LICENSE = BSD-like, rdflib (http_client.py), PSF (medusa)
SUPERVISOR_LICENSE_FILES = LICENSES.txt
SUPERVISOR_CPE_ID_VENDOR = supervisord
SUPERVISOR_SETUP_TYPE = setuptools

define SUPERVISOR_INSTALL_CONF_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/supervisor.d
	$(INSTALL) -D -m 644 package/supervisor/supervisord.conf \
		$(TARGET_DIR)/etc/supervisord.conf
endef

SUPERVISOR_POST_INSTALL_TARGET_HOOKS += SUPERVISOR_INSTALL_CONF_FILES

define SUPERVISOR_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/supervisor/S99supervisord \
		$(TARGET_DIR)/etc/init.d/S99supervisord
endef

define SUPERVISOR_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/supervisor/supervisord.service \
		$(TARGET_DIR)/usr/lib/systemd/system/supervisord.service
endef

$(eval $(python-package))
