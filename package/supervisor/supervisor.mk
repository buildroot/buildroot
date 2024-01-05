################################################################################
#
# supervisor
#
################################################################################

SUPERVISOR_VERSION = 4.2.5
SUPERVISOR_SITE = https://files.pythonhosted.org/packages/ce/37/517989b05849dd6eaa76c148f24517544704895830a50289cbbf53c7efb9
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
