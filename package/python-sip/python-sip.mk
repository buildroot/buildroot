################################################################################
#
# python-sip
#
################################################################################

PYTHON_SIP_VERSION = 4.19.25
PYTHON_SIP_SOURCE = sip-$(PYTHON_SIP_VERSION).tar.gz
PYTHON_SIP_SITE = https://www.riverbankcomputing.com/static/Downloads/sip/$(PYTHON_SIP_VERSION)
PYTHON_SIP_LICENSE = SIP license or GPL-2.0 or GPL-3.0
PYTHON_SIP_LICENSE_FILES = LICENSE LICENSE-GPL2 LICENSE-GPL3
PYTHON_SIP_DEPENDENCIES = python3 qt5base
HOST_PYTHON_SIP_DEPENDENCIES = host-python3

define HOST_PYTHON_SIP_CONFIGURE_CMDS
	(cd $(@D); \
		$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(HOST_DIR)/bin/python configure.py)
endef

define HOST_PYTHON_SIP_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define HOST_PYTHON_SIP_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) install -C $(@D)
endef

define PYTHON_SIP_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(HOST_DIR)/bin/python configure.py \
			--bindir $(TARGET_DIR)/usr/bin \
			--destdir $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages \
			--incdir $(STAGING_DIR)/usr/include/python$(PYTHON3_VERSION_MAJOR) \
			--sipdir $(TARGET_DIR)/usr/share/sip \
			--sysroot $(STAGING_DIR)/usr \
			--no-stubs \
			--use-qmake && \
		$(HOST_DIR)/bin/qmake)
endef

define PYTHON_SIP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define PYTHON_SIP_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) install -C $(@D)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
